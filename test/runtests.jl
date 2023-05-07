using TestPackage
using Test
func_add(2,1)
@testset "TestPackage.jl" begin
    # Write your tests here.
    @test func_add(2,1) == 3
    @test func_add(150,28) == 178
end
