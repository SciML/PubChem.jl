using Catalyst, HTTP, JSON, Test, SafeTestsets, PubChem

const GROUP = get(ENV, "GROUP", "all")

### Run the tests ###
@time begin
    if GROUP == "all" || GROUP == "core"
        @time @safetestset "JSON/Interface" begin
            include("interface.jl")
        end
        @time @safetestset "Chemistry" begin
            include("functions.jl")
        end
    end

    if GROUP == "all" || GROUP == "nopre"
        @time @safetestset "Allocation Tests" begin
            include("alloc_tests.jl")
        end
    end
end
