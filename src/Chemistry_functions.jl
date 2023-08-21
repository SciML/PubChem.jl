# Molar Ratios
function molar_ratio(reaction::Reaction, species1, species2)
    coeff1 = find_coefficient(reaction, species1)
    coeff2 = find_coefficient(reaction, species2)
    return Rational(coeff1, coeff2)
end

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

# Number of Moles
function moles(compound, molarity, volume)
    return compound, molarity * volume
end


function moles(compound, mass)
    weight = molecular_weight(compound)
    return mass / weight
end

# Limiting Reagent
function limiting_reagent(reaction::Reaction, masses::Array{Float64})
    reactant_moles = [masses[i] / molecular_weight(reaction.substrates[i]) for i in 1:length(reaction.substrates)]
    return reaction.substrates[argmin(reactant_moles)],minimum(reactant_moles)
end

# Theoretical Yield
function theoretical_yield(reaction::Reaction, masses::Array, product::Num)
    lr,m = limiting_reagent(reaction,masses)
    return m * molar_ratio(reaction, product, lr) * molecular_weight(product)
end


# function limiting_reagent(reaction::Reaction, masses::Dict{Any, Float64})
#     reactant_moles = [masses[compound] / molecular_weight(compound) for compound in reaction.substrates]
#     return reaction.substrates[argmin(reactant_moles)]
# end
# function theoretical_yield(reaction::Reaction, masses::Dict{Num, Float64})
#     # Calculate the number of moles of each reactant
#     reactant_moles = [masses[compound] / molecular_weight(compound) for compound in reaction.substrates]
    
#     # Identify the limiting reactant
#     limiting = reaction.substrates[argmin(reactant_moles)]
    
#     # Calculate the stoichiometric coefficient ratio
#     index = findfirst(isequal(limiting), reaction.substrates)
#     coeff_ratio = reaction.substoich[index] / minimum(reaction.substoich)
    
#     # Calculate the theoretical yield
#     return (masses[limiting] / molecular_weight(limiting)) * molecular_weight(reaction.products[1]) * coeff_ratio
# end



# function percent_yield(reaction::Reaction, masses, actual_yield)
#     return (actual_yield / theoretical_yield(reaction, masses)) * 100
# end


# @variables t
# @species Fe(t) O(t) H(t)
# @species O2(t)
# @species H2O(t) 
# @species FeOH3(t)
# balanced_rx = Reaction(1.0, [Fe, O2, H2O], [FeOH3], [4, 3, 6], [4])
# ratio = molar_ratio(balanced_rx, O2, Fe)

# function molar_ratio(reaction::Reaction, species...)
#     coeffs = [find_coefficient(reaction, sp) for sp in species]
#     gcd_value = gcd(coeffs...)
#     return [div(c, gcd_value) for c in coeffs]
# end
# @parameters k
# @species C6H12O6(t), O2(t), CO2(t), H2O(t)
# @species Al(t), Cl2(t), AlCl3(t)

# reaction = Reaction(k, [Al, Cl2], [AlCl3], [2, 3], [2])


# @Attach_Metadata Al 
# @Attach_Metadata Cl2 
# @Attach_Metadata AlCl3 

# molecular_weight(AlCl3)
# theoretical_yield = theoretical_yield(reaction, masses)

# println("Theoretical yield: ", theoretical_yield)

# isequal(typeof(C6H12O6),reaction.substrates)

# X = reaction.substrates
# print(X)

# typeof(X)
# x = [molecular_weight(compound) for compound in reaction.substrates]


# function limiting_reagent_and_yield(reaction::Reaction, masses::Array{Float64})
#     reactant_moles = [masses[i] / molecular_weight(reaction.substrates[i]) for i in 1:length(reaction.substrates)]
#     limiting_reagent_index = argmin(reactant_moles)
#     limiting_reagent = reaction.substrates[limiting_reagent_index]

#     # Calculate the stoichiometric ratio of the limiting reagent to the product
#     stoichiometric_ratio = stoichiometry[limiting_reagent_index] / stoichiometry[end]

#     # Calculate the theoretical yield in moles
#     theoretical_yield_moles = reactant_moles[limiting_reagent_index] * stoichiometric_ratio

#     # Convert the theoretical yield from moles to grams
#     theoretical_yield_grams = theoretical_yield_moles * molecular_weight(reaction.products[1])

#     return limiting_reagent, theoretical_yield_grams
# end

# moles(Cl2,4.15)*molar_ratio(reaction,AlCl3,Cl2)*molecular_weight(AlCl3)

# @species BaCl2(t) AgNO3(t) AgCl(t) BaN2O6(t)

# @Attach_Metadata BaN2O6 24798

# molecular_weight(BaN2O6)

# rx = Reaction(1.0, [BaCl2, AgNO3], [AgCl,BaN2O6], [1, 2], [2,1])

# limiting_reagent(rx,[])

# moles(BaCl2,0.314,0.0250)

# Theoretical_yield(reaction,[2.80,4.15],AlCl3)
