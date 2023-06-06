
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
    split_reaction = split(reaction, "→")
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
    coeffs = round.(Int, coeffs ./ minimum(coeffs[coeffs .> 0]))  # normalize the coefficients to be integers
    
    balanced_reactants = [string(coeffs[j], reactants[j]) for j in 1:length(reactants)]
    balanced_products = [string(coeffs[j + length(reactants)], products[j]) for j in 1:length(products)]
    
    balanced_reaction = join(balanced_reactants, " + ") * " → " * join(balanced_products, " + ")
    
    return balanced_reaction
end


export balance_reaction
