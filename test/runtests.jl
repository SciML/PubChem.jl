using Catalyst, HTTP, JSON, Test, SafeTestsets, PubChem

### Run the tests ###
@time begin
    @time @safetestset "JSON/Interface" begin
        include("interface.jl")
    end
    @time @safetestset "Chemistry" begin
        include("functions.jl")
    end
end
