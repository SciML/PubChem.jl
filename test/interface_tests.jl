using Test
using Catalyst
using PubChem

@testset "Type Genericity" begin
    @variables t
    @species Al(t), Cl2(t), AlCl3(t)
    @attach_metadata Al
    @attach_metadata Cl2
    @attach_metadata AlCl3

    reaction = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

    @testset "BigFloat support" begin
        # Test limiting_reagent with BigFloat
        masses_bf = BigFloat[2.80, 4.15]
        lr, moles = limiting_reagent(reaction, masses_bf)
        @test isequal(lr, Cl2)
        @test moles isa BigFloat
        @test isapprox(Float64(moles), 0.05853314527503526; rtol=1e-10)

        # Test theoretical_yield with BigFloat
        yield = theoretical_yield(reaction, masses_bf, AlCl3)
        @test yield isa BigFloat
        @test isapprox(Float64(yield), 5.203206393982134; rtol=1e-10)
    end

    @testset "Float32 support" begin
        # Test limiting_reagent with Float32
        masses_f32 = Float32[2.80, 4.15]
        lr, moles = limiting_reagent(reaction, masses_f32)
        @test isequal(lr, Cl2)
        @test isapprox(moles, 0.05853314527503526; rtol=1e-5)

        # Test theoretical_yield with Float32
        yield = theoretical_yield(reaction, masses_f32, AlCl3)
        @test isapprox(yield, 5.203206393982134; rtol=1e-5)
    end

    @testset "Float64 support (baseline)" begin
        # Test limiting_reagent with Float64
        masses_f64 = [2.80, 4.15]
        lr, moles = limiting_reagent(reaction, masses_f64)
        @test isequal(lr, Cl2)
        @test moles isa Float64
        @test isapprox(moles, 0.05853314527503526; rtol=1e-10)

        # Test theoretical_yield with Float64
        yield = theoretical_yield(reaction, masses_f64, AlCl3)
        @test yield isa Float64
        @test isapprox(yield, 5.203206393982134; rtol=1e-10)
    end

    @testset "moles_by_volume with BigFloat" begin
        result = moles_by_volume(BigFloat("0.300"), BigFloat("0.400"))
        @test result isa BigFloat
        @test isapprox(Float64(result), 0.12; rtol=1e-10)
    end

    @testset "moles_by_mass with BigFloat" begin
        @species MnO2(t)
        @attach_metadata MnO2

        result = moles_by_mass(MnO2, BigFloat("95"))
        @test result isa BigFloat
        @test isapprox(Float64(result), 1.0927453213246374; rtol=1e-10)
    end
end
