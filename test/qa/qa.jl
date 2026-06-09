using PubChem
using Aqua
using JET
using Test

@testset "Aqua" begin
    Aqua.test_all(PubChem)
end

@testset "JET" begin
    JET.test_package(PubChem; target_defined_modules = true)
end
