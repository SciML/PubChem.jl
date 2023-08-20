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

# @variables t
# @species Fe(t) O(t) H(t)
# @species O2(t)
# @species H2O(t) 
# @species FeOH3(t)
# balanced_rx = Reaction(1.0, [Fe, O2, H2O], [FeOH3], [4, 3, 6], [4])
# ratio = molar_ratio(balanced_rx, O2, Fe)
