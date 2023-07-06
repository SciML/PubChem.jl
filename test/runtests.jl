using TestPackage, Test , LinearAlgebra

@testset "PubChem" begin
    get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/962/json") isa Dict
    get_json_from_name("Oxygen") isa Dict
    get_json_from_cid(962) isa Dict

    get_compound_properties("Silicon") isa Dict
    get_compound_properties(962) isa Dict
end


@testset "parse_formula" begin
# Test parse_formula
formula1 = parse_formula("H2O")
@test formula1 == Dict("H" => 2, "O" => 1)

formula2 = parse_formula("C6H12O6")
@test formula2 == Dict("C" => 6, "H" => 12, "O" => 6)

formula3 = parse_formula("SiCl4")
@test formula3 == Dict("Si" => 1, "Cl" => 4)

end


@testset "balance_reaction" begin
# Test balance_reaction
reaction1 = balance_reaction("H2 + O2 --> H2O")
@test reaction1 == "2H2+1O2-->2H2O"

reaction2 = balance_reaction("C + O2 --> CO2")
@test reaction2 == "1C+1O2-->1CO2"

reaction3 = balance_reaction("CO2 + H2O --> C6H12O6 + O2")
@test reaction3 == "6CO2+6H2O-->1C6H12O6+6O2"

reaction4 = balance_reaction("H2 + Cl2 --> HCl")
@test reaction4 == "1H2+1Cl2-->2HCl"

end

@testset "metadata" begin

    Nitrogen = Compound("N","Nitrogen")
    @test Compound("N","Nitrogen") isa Compound
    @test Nitrogen.metadata isa Dict
    @test Nitrogen.metadata["molecular_weight"] isa String
    @test Nitrogen.name == "N"
    Water = Compound("H2O",962)
    @test Compound("H2O",962) isa Compound
    @test Water.metadata isa Dict
    @test Water.name == "H2O"
    
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

