using AllocCheck
using PubChem
using Test

@testset "Allocation Tests" begin
    @testset "moles_by_volume - allocation-free" begin
        # moles_by_volume is a simple arithmetic operation that should not allocate
        @check_allocs checked_moles_by_volume(molarity::Float64, volume::Float64) = PubChem.moles_by_volume(molarity, volume)

        # Test that it works correctly
        @test checked_moles_by_volume(0.300, 0.400) == 0.12
        @test checked_moles_by_volume(1.0, 1.0) == 1.0
        @test checked_moles_by_volume(0.5, 2.0) == 1.0

        # Verify zero allocations
        @test (@allocated moles_by_volume(0.300, 0.400)) == 0
    end
end
