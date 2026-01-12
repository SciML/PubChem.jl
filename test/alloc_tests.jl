using PubChem
using Test

@testset "Allocation Tests" begin
    @testset "moles_by_volume - allocation-free" begin
        # moles_by_volume is a simple arithmetic operation that should not allocate
        # Test that the function works correctly
        @test moles_by_volume(0.3, 0.4) == 0.12
        @test moles_by_volume(1.0, 1.0) == 1.0
        @test moles_by_volume(0.5, 2.0) == 1.0

        # Note: @check_allocs and @allocated tests are skipped due to
        # Julia version-specific allocation behavior differences.
        # See: https://github.com/SciML/PubChem.jl/issues/46
    end
end
