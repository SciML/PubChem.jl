using ExplicitImports
using PubChem
using Test

@testset "ExplicitImports" begin
    @test check_no_implicit_imports(PubChem) === nothing
    @test check_no_stale_explicit_imports(PubChem) === nothing
end
