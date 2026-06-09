using Catalyst, HTTP, JSON, Test, SafeTestsets, PubChem

const GROUP = get(ENV, "GROUP", "All")

### Run the tests ###
@time begin
    if GROUP == "All" || GROUP == "Core"
        @time @safetestset "JSON/Interface" begin
            include("interface.jl")
        end
        @time @safetestset "Chemistry" begin
            include("functions.jl")
        end
        @time @safetestset "Type Genericity" begin
            include("interface_tests.jl")
        end
        @time @safetestset "Explicit Imports" begin
            include("explicit_imports.jl")
        end
        @time @safetestset "Allocation Tests" begin
            include("alloc_tests.jl")
        end
    end

    if GROUP == "QA"
        @time @safetestset "Quality Assurance" begin
            include("qa/qa.jl")
        end
    end
end
