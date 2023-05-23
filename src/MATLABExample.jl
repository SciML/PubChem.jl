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
