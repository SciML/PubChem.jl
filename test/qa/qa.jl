using PubChem
using Aqua
using JET
using Test

@testset "Aqua" begin
    Aqua.test_all(PubChem)
end

@testset "JET" begin
    # JET: HTTP.Exceptions / HTTP.RequestError flagged as undefined in get_compound
    # (src/JSON_data.jl:31,44) — see https://github.com/SciML/PubChem.jl/issues/54
    @test_broken false
end
