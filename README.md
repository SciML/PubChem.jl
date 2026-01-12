# PubChem.jl

[![Latest Release (for users)](https://img.shields.io/badge/docs-latest_release_(for_users)-blue.svg)](https://sciml.github.io/PubChem.jl/stable/)
[![Master (for developers)](https://img.shields.io/badge/docs-master_branch_(for_devs)-blue.svg)](https://sciml.github.io/PubChem.jl/dev/)
[![codecov](https://codecov.io/gh/SciML/PubChem.jl/graph/badge.svg?token=UzwzLav3J7)](https://codecov.io/gh/SciML/PubChem.jl)

PubChem.jl is a powerful Julia package that facilitates easy access to chemical data from the PubChem database and associates it with chemical species defined using the Catalyst.jl package. This allows you to seamlessly integrate chemical metadata into your computational workflows.

### Example Usage

Suppose we want to retrieve chemical properties for the species `H2O`. First, we define the species and attach the appropriate metadata:

```julia
using PubChem, Catalyst
@variables t
@species H2O(t)
@attach_metadata H2O
```

Now, our species `H2O` holds chemical data fetched from PubChem as its metadata. We can query this data:

```julia
julia> chemical_properties(H2O)
Dict{Any, Any} with 7 entries:
  "IUPAC_Name_Preferred"   => "oxidane"
  "IUPAC_Name_Traditional" => "water"
  "Charge"                 => 0
  "Molecular_formula"      => "H2O"
  "Molecular_mass"         => 18.0106
  "Molecular_weight"       => 18.015
  "Smiles"                 => "O"
```

You can also query the properties directly, by name, by CID, or by formula, even if you are not using Catalyst.
This fetches it from PubChem directly.

```julia
julia> chemical_properties("oxidane")
Dict{Any, Any} with 7 entries:
  "IUPAC_Name_Preferred"   => "oxidane"
  "IUPAC_Name_Traditional" => "water"
  "Charge"                 => 0
  "Molecular_formula"      => "H2O"
  "Molecular_mass"         => 18.0106
  "Molecular_weight"       => 18.015
  "Smiles"                 => "O"

julia> chemical_properties(962)
Dict{Any, Any} with 7 entries:
  "IUPAC_Name_Preferred"   => "oxidane"
  "IUPAC_Name_Traditional" => "water"
  "Charge"                 => 0
  "Molecular_formula"      => "H2O"
  "Molecular_mass"         => 18.0106
  "Molecular_weight"       => 18.015
  "Smiles"                 => "O"

julia> chemical_properties("H2O")
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

With metadata attached to species directly, you can now utilize these chemical properties to perform various calculations, such as determining the limiting reactant and calculating theoretical yields in a balanced Catalyst reaction.

As an example, let's consider the reaction `2Al + 3Cl2 --> 2AlCl3` and suppose we have the masses of `Al` and `Cl2` as 2.80g and 4.15g, respectively.

```julia
@variables t
@species Al(t), Cl2(t), AlCl3(t)

# Attach metadata to the species
@attach_metadata Al
@attach_metadata Cl2
@attach_metadata AlCl3

# Define a balanced Catalyst reaction
rx = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

# Get limiting reagent given the masses of the reactants
julia> limiting_reagent(rx, [2.80, 4.15])
(Cl2(t), 0.05853314527503526) # Returns the limiting reagent and its number of moles

# Calculate theoretical yield given the masses of the reactants and the product for which to calculate
julia> theoretical_yield(rx, [2.80, 4.15], AlCl3)
5.203206393982134
```

## See also

  - [PubChemCrawler.jl](https://github.com/JuliaHealth/PubChemCrawler.jl) a similar package without the Catalyst.jl integration, but with more comprehensive PubChem querying.
