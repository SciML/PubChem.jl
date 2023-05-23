using Catalyst
using Symbolics
using ModelingToolkit

# Define a chemical reaction system
rn = @reaction_network begin
    k1, A + B --> C
    k2, C --> D
end 

# Get the species symbols from the ReactionSystem
species = states(rn)

# Initialize reactants and products as arrays of arrays
reactants = Vector{Vector{Symbol}}(undef, length(rn.eqs))
products = Vector{Vector{Symbol}}(undef, length(rn.eqs))
