"""
    molar_ratio(reaction::Reaction, species1, species2)

Return the stoichiometric ratio of `species1` to `species2` in `reaction`.

# Arguments
- `reaction::Reaction`: A Catalyst reaction containing both species.
- `species1`: The numerator species.
- `species2`: The denominator species.

# Returns
- A `Rational` equal to the stoichiometric coefficient of `species1` divided by that
  of `species2`.

# Throws
- `ErrorException`: Either species is not a substrate or product of `reaction`.

# Examples
```julia
molar_ratio(reaction, Al, Cl2) # 2//3 for 2Al + 3Cl2 -> 2AlCl3
```
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
    moles_by_volume(molarity, volume)

Calculate the number of moles in a solution from molarity and volume.

# Arguments
- `molarity`: Amount concentration in mol/L.
- `volume`: Solution volume in L.

# Returns
- The product `molarity * volume`, preserving the arithmetic type selected by the
  input values.

# Examples
```julia
moles_by_volume(0.400, 0.300) == 0.120
```
"""
function moles_by_volume(molarity, volume)
    return molarity * volume
end

"""
    moles_by_mass(species, mass)

Calculate the amount of `species` from a supplied mass.

# Arguments
- `species`: A metadata-annotated symbolic species, compound name, or PubChem CID
  accepted by [`molecular_weight`](@ref).
- `mass`: Mass in grams.

# Returns
- `mass / molecular_weight(species)` in moles.

# Examples
```julia
@variables t
@species MnO2(t)
@attach_metadata MnO2

moles_by_mass(MnO2, 95)
```
"""
function moles_by_mass(compound, mass)
    weight = molecular_weight(compound)
    return mass / weight
end

"""
    limiting_reagent(reaction::Reaction, masses::AbstractVector)

Find the substrate with the fewest available moles in a reaction.

# Arguments
- `reaction::Reaction`: A balanced Catalyst reaction.
- `masses::AbstractVector`: Substrate masses in grams, in the same order as
  `reaction.substrates`.

# Returns
A tuple `(limiting_species, moles)`, where `moles` is the available amount of that
species.

# Throws
- `ArgumentError`: `masses` does not support fast scalar indexing. GPU arrays are not
  supported because the calculation scans values on the host.

# Examples
```julia
limiting_reagent(reaction, [2.8, 4.15]) # (Cl2, 0.0585...)
```
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

Calculate the theoretical mass yield of a product from substrate masses.

# Arguments
- `reaction::Reaction`: A balanced Catalyst reaction.
- `masses::AbstractVector`: Substrate masses in grams, ordered as
  `reaction.substrates`.
- `product::Num`: A product symbolic species in `reaction`.

# Returns
The theoretical product mass in grams.

# Throws
- `ArgumentError`: `masses` does not support fast scalar indexing.
- `ErrorException`: `product` is not in `reaction`.

# Examples
```julia
theoretical_yield(reaction, [2.8, 4.15], AlCl3) # 5.2032...
```
"""
function theoretical_yield(reaction::Reaction, masses::AbstractVector, product::Num)
    lr, m = limiting_reagent(reaction, masses)
    return m * molar_ratio(reaction, product, lr) * molecular_weight(product)
end
