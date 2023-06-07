using TestPackage, Test , LinearAlgebra

@testset "TestPackage.jl" begin
    a = get_compound(962)
    b = get_compound("water")
    
    @test a == b
    @test a isa Dict

    @test extract_properties(a) isa Dict
    @testset "testbalance.jl" begin include("testbalance.jl") end

end

# # define Reaction (refer to Catalyst for the full answer)
# struct Reaction
#     r
#     p
# end

# dict,array

# # take an example reaction and start to balance it 
# # http://mathgene.usc.es/matlab-profs-quimica/reacciones.pdf
# # OH- + H+ -> H2O
# [1,1] [1]
# r = ["water" , "CO2"]
# r = Dict(["water"=>1 , "CO2"=>3]

# balance(reaction) = TODO

