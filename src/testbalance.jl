function parse_formula(formula)
    elements = Dict{String, Int}()
    i = 1
    while i <= length(formula)
        # Extract the element symbol
        if i < length(formula) && occursin(r"[a-z]", string(formula[i+1]))
            symbol = formula[i:i+1]
            i += 2
        else
            symbol = formula[i:i]
            i += 1
        end
        # Extract the stoichiometric coefficient
        j = i
        while j <= length(formula) && occursin(r"[0-9]", string(formula[j]))
            j += 1
        end
        if i == j
            coeff = 1
        else
            coeff = parse(Int, formula[i:j-1])
        end
        i = j
        # Update the elements dictionary
        elements[symbol] = get(elements, symbol, 0) + coeff
    end
    return elements
end

function balance_reaction(reaction)
    split_reaction = split(reaction, "-->")
    reactants = split(split_reaction[1], "+")
    products = split(split_reaction[2], "+")

    reactants = strip.(reactants)
    products = strip.(products)

    reactant_elements = [parse_formula(r) for r in reactants]
    product_elements = [parse_formula(p) for p in products]
    
    elements = Set{String}()
    for reactant in reactant_elements
        for key in keys(reactant)
            push!(elements, key)
        end
    end
    for product in product_elements
        for key in keys(product)
            push!(elements, key)
        end
    end
    
    A = zeros(Int, length(elements), length(reactants) + length(products))
    
    for (i, element) in enumerate(elements)
        for (j, reactant) in enumerate(reactant_elements)
            A[i, j] = get(reactant, element, 0)
        end
        for (j, product) in enumerate(product_elements)
            A[i, j + length(reactants)] = -get(product, element, 0)
        end
    end
    
    coeffs = nullspace(A)
    positive_coeffs = coeffs[coeffs .> 0]

    if isempty(positive_coeffs)
        return "Reaction cannot be balanced: coefficients do not allow for a balanced reaction."
    end

    coeffs = round.(Int, coeffs ./ minimum(positive_coeffs))  # normalize the coefficients to be integers
    
    balanced_reactants = [string(coeffs[j], reactants[j]) for j in 1:length(reactants)]
    balanced_products = [string(coeffs[j + length(reactants)], products[j]) for j in 1:length(products)]
    
    balanced_reaction = join(balanced_reactants, "+") * "-->" * join(balanced_products, "+")
    
    # Remove all whitespaces
    balanced_reaction = replace(balanced_reaction, " " => "")
    
    return balanced_reaction
end


export balance_reaction

function extract_coefficients(reaction_str)
    reactions = split(reaction_str, "-->") 

    # get reactants and coefficients
    reactants_info = split(reactions[1], "+")
    reactant_coefficients = [parse(Int, r[1]) for r in reactants_info]

    # get products and coefficients
    products_info = split(reactions[2], "+")
    product_coefficients = [parse(Int, p[1]) for p in products_info]

    reactant_coefficients, product_coefficients
end

# reaction_str = "2H2+1O2-->2H2O" # your chemical equation here
# reactant_coeff, product_coeff = extract_coefficients(reaction_str)
# Gives 2 arrays with stoich values for reactants and products respectively
# Assumes the coefficients to be always single digit for now

function extract_species(reaction_str)
    reactions = split(reaction_str, "-->") 

    # get reactants and species
    reactants_info = split(reactions[1], "+")
    reactant_species = [String(r[2:end]) for r in reactants_info]

    # get products and species
    products_info = split(reactions[2], "+")
    product_species = [String(p[2:end]) for p in products_info]

    reactant_arr = vcat([eval(Meta.parse("@species $species(t)")) for species in reactant_species]...)
    product_arr = vcat([eval(Meta.parse("@species $species(t)")) for species in product_species]...)

    reactant_arr, product_arr
end

# reaction_str = "2H2+1O2-->2H2O" # your chemical equation here
# reactant_coeff, product_coeff = extract_species(reaction_str)
# Gives 2 arrays with species values for reactants and products respectively:(Num[H2(t), O2(t)], Num[H2O(t)]) 
# Automatically creates the species required for the reaction 

# Reaction(k,reactant_arr  ,product_arr,reactant_coeff, product_coeff) #WORKS

function create_balanced_reaction(reaction_str)
    # Balance the reaction.
    balanced_reaction_str = balance_reaction(reaction_str)

    # Extract the coefficients and species from the balanced reaction.
    reactant_coeff, product_coeff = extract_coefficients(balanced_reaction_str)
    reactant_arr, product_arr = extract_species(balanced_reaction_str)

    # Create and return the balanced reaction.
    return Reaction(k, reactant_arr, product_arr, reactant_coeff, product_coeff)
end

# Example usage
# reaction = create_balanced_reaction("CO2 + H2O --> C6H12O6 + O2") gives k, 6*CO2 + 6*H2O --> C6H12O6 + 6*O2
# typeof(reaction) gives Reaction{Any, Int64}
# println(reaction)
# add this balanced reaction to a reaction network using Catalyst.!addreaction
