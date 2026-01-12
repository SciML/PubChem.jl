"""
    molar_ratio(reaction::Reaction, species1, species2)

Calculate the molar ratio of two species in a reaction.

# Arguments
- `reaction`: A Catalyst reaction
- `species1`: First species in the reaction
- `species2`: Second species in the reaction

# Returns
A `Rational` number representing the ratio of the stoichiometric coefficients of `species1` to `species2`.
"""
function molar_ratio(reaction::Reaction, species1, species2)
    coeff1 = find_coefficient(reaction, species1)
    coeff2 = find_coefficient(reaction, species2)
    return Rational(coeff1, coeff2)
end

# Find the coefficient of the given species in the reaction
function find_coefficient(reaction::Reaction, species)
    index = findfirst(isequal(species), reaction.substrates)
    if index !== nothing
        return reaction.substoich[index]
    end
    index = findfirst(isequal(species), reaction.products)
    if index !== nothing
        return reaction.prodstoich[index]
    end
    error("Species not found in reaction.")
end

"""
    moles_by_volume(molarity::Float64, volume::Float64)

Calculate number of moles given the molarity and volume.

# Arguments
- `molarity`: Molarity of the solution (in mol/L)
- `volume`: Volume of the solution (in liters)

# Example
Given a solution with molarity 0.400 mol/L and volume 0.300 L:
```julia
moles_by_volume(0.400, 0.300) == 0.120
```

"""

# Calculate number of moles given the molarity and volume
function moles_by_volume(molarity, volume)
    return molarity * volume
end

"""
    moles_by_mass(species, mass::Float64)

Calculate number of moles given the compound and its mass.

# Example
```julia
@variables t
@species MnO2(t)
@attach_metadata MnO2

moles_by_mass(MnO2, 95)
```

"""

# Calculate number of moles given the compound and its mass.
function moles_by_mass(compound, mass)
    weight = molecular_weight(compound)
    return mass / weight
end

"""
    limiting_reagent(reaction::Reaction, masses::AbstractVector)

Calculate the limiting reagent in the reaction given the masses of the reactants.

# Arguments
- `reaction`: A balanced Catalyst reaction
- `masses`: Vector of masses of the reactants (in grams)

# Returns
A tuple `(limiting_species, moles)` where `limiting_species` is the limiting reagent and `moles` is its number of moles.

# Note
This function requires arrays with fast scalar indexing. GPU arrays (e.g., CuArray)
are not supported due to the iterative nature of the algorithm.
"""

function limiting_reagent(reaction::Reaction, masses::AbstractVector)
    if !ArrayInterface.fast_scalar_indexing(masses)
        throw(
            ArgumentError(
                "limiting_reagent requires arrays with fast scalar indexing. " *
                    "GPU arrays are not supported for this operation. " *
                    "Use `Array(masses)` to convert to a CPU array first."
            )
        )
    end
    substrates = reaction.substrates
    n = length(substrates)
    @inbounds begin
        min_moles = masses[1] / molecular_weight(substrates[1])
        min_idx = 1
        for i in 2:n
            moles = masses[i] / molecular_weight(substrates[i])
            if moles < min_moles
                min_moles = moles
                min_idx = i
            end
        end
        return substrates[min_idx], min_moles
    end
end

"""
    theoretical_yield(reaction::Reaction, masses::AbstractVector, product::Num)

Calculate the theoretical yield (in grams) of the given product species in the reaction, given the masses of the reactants.

# Arguments
- `reaction`: A balanced Catalyst reaction
- `masses`: Vector of masses of the reactants (in grams)
- `product`: The product species for which to calculate the theoretical yield

# Returns
The theoretical yield in grams.
"""

function theoretical_yield(reaction::Reaction, masses::AbstractVector, product::Num)
    lr, m = limiting_reagent(reaction, masses)
    return m * molar_ratio(reaction, product, lr) * molecular_weight(product)
end
