# PubChem.jl

[![CI](https://github.com/LalitChauhan56/PubChem.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/LalitChauhan56/PubChem.jl/actions/workflows/CI.yml)
[![Coverage](https://codecov.io/gh/LalitChauhan56/PubChem.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LalitChauhan56/PubChem.jl)


PubChem.jl is a powerful Julia package that facilitates easy access to chemical data from the PubChem database and associates it with chemical species defined using the Catalyst.jl package. This allows you to seamlessly integrate chemical metadata into your computational workflows.

### Example Usage

Suppose we want to retrieve chemical properties for the species `H2O`. First, we define the species and attach the appropriate metadata:

```julia
using PubChem, Catalyst
@variables t
@species H2O(t)
@Attach_Metadata H2O
```

Now, our species `H2O` holds chemical data fetched from PubChem as its metadata. We can query this data:

```julia
julia> properties(H2O)
Dict{Any, Any} with 7 entries:
  "IUPAC_Name_Preferred"   => "oxidane"
  "IUPAC_Name_Traditional" => "water"
  "Charge"                 => 0
  "Molecular_formula"      => "H2O"
  "Molecular_mass"         => 18.0106
  "Molecular_weight"       => 18.015
  "Smiles"                 => "O"
```

#### Chemical Calculations

You can now utilize these chemical properties to perform various calculations, such as determining the limiting reactant and calculating theoretical yields in a balanced Catalyst reaction.

As an example, let's consider the reaction `2Al + 3Cl2 --> 2AlCl3` and suppose we have the masses of `Al` and `Cl2` as 2.80g and 4.15g, respectively.

```julia
# Define the species involved in the reaction
@variables t
@species Al(t), Cl2(t), AlCl3(t)

# Attach metadata to the species
@Attach_Metadata Al 
@Attach_Metadata Cl2 
@Attach_Metadata AlCl3 

# Define a balanced Catalyst reaction 
rx = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

# Get limiting reagent given the masses of the reactants
julia> limiting_reagent(reaction,[2.80,4.15])
(Cl2(t), 0.05853314527503526) # Returns the limiting reagent and it's number of moles

# Calculate theoretical yield given the masses of the reactants and the product for which to calculate
julia> theoretical_yield(reaction,[2.80,4.15],AlCl3)
5.203206393982134 # 5.2g of AlCl3 is produced 
```


  
