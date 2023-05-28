# Balancing reactions using http://mathgene.usc.es/matlab-profs-quimica/reacciones.pdf
##CH4 + O2 → CO2 + H2O

using LinearAlgebra

# Define stoichiometric matrix
A = [1 0 -1 0;
     4 0 0 -2;
     0 2 -2 -1;
     0 0 0 1]

# Define the b vector
b = [0, 0, 0, 1]

# Solve the system of linear equations Ax = b
x = A \ b

# Find smallest non-zero value in x
min_val = minimum(filter(x -> x != 0, x))

# Normalize coefficients to be integers
x_normalized = x / min_val

println("The solution vector x is: ", x)
println("The normalized solution vector x is: ", x_normalized)

## H2 + 02 = H20
using LinearAlgebra

# Define stoichiometric matrix
A = [2 0 -2;
     0 2 -1;
     0 0 1]

# Define the b vector
b = [0, 0, 1]

# Solve the system of linear equations Ax = b
x = A \ b

# Find smallest non-zero value in x
min_val = minimum(filter(x -> x != 0, x))

# Normalize coefficients to be integers
x_normalized = x / min_val

println("The solution vector x is: ", x)
println("The normalized solution vector x is: ", x_normalized)

##Now I have to just figure out a way to dynamically construct these matrices and store coefficients into them by parsing a reaction

using LinearAlgebra

function parse_formula(formula)
    elements = Dict{String, Int64}()
    element = ""
    count = ""

    for char in formula
        if isdigit(char)
            count = string(count, char)
        elseif isuppercase(char)
            if element != ""
                update_elements(elements, element, count)
                count = ""
            end
            element = string(char)
        else
            element = string(element, char)
        end
    end

    if element != ""
        update_elements(elements, element, count)
    end

    return elements
end

function update_elements(elements, element, count)
    if count == ""
        elements[element] = get(elements, element, 0) + 1
    else
        elements[element] = get(elements, element, 0) + parse(Int64, count)
    end
end

function form_stoichiometric_matrix(reaction)
    sides = split(reaction, "→")
    reactants = split(strip(sides[1]), '+')
    products = split(strip(sides[2]), '+')

    all_elements = Set{String}()
    for formula in [reactants; products]
        for form in formula
            elements = keys(parse_formula(form))
            for element in elements
                push!(all_elements, element)
            end
        end
    end

    A = zeros(Int64, length(all_elements), length(reactants) + length(products))
    element_indices = Dict(element => i for (i, element) in enumerate(all_elements))

    formulas = [reactants; products]
    for i = 1:length(reactants)
        formula = reactants[i]
        elements = parse_formula(formula)
        for (element, count) in elements
            j = get(element_indices, element, nothing)
            if j != nothing
                A[j, i] = count
            end
        end
    end

    for i = 1:length(products)
        formula = products[i]
        elements = parse_formula(formula)
        for (element, count) in elements
            j = get(element_indices, element, nothing)
            if j != nothing
                A[j, i+length(reactants)] = -count
            end
        end
    end

    b = zeros(Int64, length(all_elements))

    return A, b, reactants, products
end


reaction = "CH4 + O2 → CO2 + H2O"
A, b, reactants, products = form_stoichiometric_matrix(reaction)

# Solve the system of linear equations Ax = b
x = A \ b

# Find smallest non-zero value in x
min_val = minimum(filter(x -> x != 0, x))

# Normalize coefficients to be integers
x_normalized = x / min_val

println("The solution vector x is: ", x)
println("The normalized solution vector x is: ", x_normalized)

println(b)

# Not working the way intended, WIP.