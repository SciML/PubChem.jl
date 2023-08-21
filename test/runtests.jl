using PubChem, Test

@testset "PubChem" begin
    a = get_compound(962)
    b = get_compound("water")
    
    @test a == b
    @test a isa Dict

    @test extract_properties(a) isa Dict

end


