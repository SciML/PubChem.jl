using Downloads, PubChem, Sockets, Test

function with_http_responses(f, statuses, bodies)
    server = listen(ip"127.0.0.1", 0)
    times = UInt64[]
    task = @async begin
        while isopen(server)
            socket = try
                accept(server)
            catch
                isopen(server) && rethrow()
                break
            end
            try
                while !isempty(readline(socket)) end
                push!(times, time_ns())
                index = min(length(times), length(statuses))
                body = bodies[index]
                write(socket, "HTTP/1.1 $(statuses[index]) Response\r\n")
                write(socket, "Content-Length: $(sizeof(body))\r\nConnection: close\r\n\r\n", body)
            finally
                close(socket)
            end
        end
    end
    try
        return f("http://127.0.0.1:$(getsockname(server)[2])", times)
    finally
        close(server)
        wait(task)
    end
end

@testset "HTTP server errors back off before retrying" begin
    for status in (500, 503, 599)
        with_http_responses([status, status, 200], ["unavailable", "unavailable", "{\"ok\":true}"]) do url, times
            @test PubChem.get_json_from_url(url; retry_delay = 0.1) == Dict("ok" => true)
            @test length(times) == 3
            # Only lower bounds are checked so a busy runner can delay requests freely.
            @test (times[2] - times[1]) / 1.0e9 >= 0.09
            @test (times[3] - times[2]) / 1.0e9 >= 0.19
        end
    end
end

@testset "HTTP retries are bounded and selective" begin
    for (status, retries, expected_requests) in ((503, 2, 3), (503, 0, 1), (404, 2, 1))
        with_http_responses([status], ["unavailable"]) do url, times
            err = try
                PubChem.get_json_from_url(url; retries, retry_delay = 0)
            catch caught
                caught
            end
            @test err isa Downloads.RequestError
            @test err.response.status == status
            @test length(times) == expected_requests
        end
    end
    with_http_responses([200], ["{\"ok\":true}"]) do url, times
        @test PubChem.get_json_from_url(url) == Dict("ok" => true)
        @test length(times) == 1
    end
    with_http_responses([200], ["invalid json"]) do url, times
        @test_throws ArgumentError PubChem.get_json_from_url(url; retry_delay = 0)
        @test length(times) == 1
    end
end
