using  Catalyst, HTTP, JSON, Test, SafeTestsets ,PubChem

### Run the tests ###
@time begin
    @time @safetestset "JSON" begin include("Interface.jl") end
    @time @safetestset "Chemistry" begin include("functions.jl") end
end 



