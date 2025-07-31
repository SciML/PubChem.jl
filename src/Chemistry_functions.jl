"""
    molar_ratio(reaction::Reaction, species, species)

Calculate Molar ratio of two elements in a reaction.
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

Example:
Given 0.300 L of 0.400 mol/L of NaCl solution
```julia
moles_by_volume(0.300,0.400) == 0.120
```

"""

# Calculate number of moles given the molarity and volume
function moles_by_volume(molarity, volume)
    return molarity * volume
end

"""
    moles_by_mass(species, mass::Float64)

Calculate number of moles given the compound and it's mass.

Example:
```julia
@variables t
@species MnO2(t)
@attach_metadata MnO2

moles_by_mass(MnO2,95)
```

"""

# Calculate number of moles given the compound and it's mass.
function moles_by_mass(compound, mass)
    weight = molecular_weight(compound)
    return mass / weight
end

"""
    limiting_reagent(reaction::Reaction, masses::Array{Float64})

Calculate the limiting reagent in the reaction given the masses of the reactants.

"""

function limiting_reagent(reaction::Reaction, masses::Array{Float64})
    reactant_moles = [masses[i] / molecular_weight(reaction.substrates[i])
                      for i in 1:length(reaction.substrates)]
    return reaction.substrates[argmin(reactant_moles)], minimum(reactant_moles)
end

"""
    theoretical_yield(reaction::Reaction, masses::Array, product::Num)

Calculate the theoretical yield of the given species in the reaction given the masses of the reactants.
"""

function theoretical_yield(reaction::Reaction, masses::Array, product::Num)
    lr, m = limiting_reagent(reaction, masses)
    return m * molar_ratio(reaction, product, lr) * molecular_weight(product)
end
