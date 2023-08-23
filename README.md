# PubChem

[![CI](https://github.com/LalitChauhan56/PubChem.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/LalitChauhan56/PubChem.jl/actions/workflows/CI.yml)
[![Coverage](https://codecov.io/gh/LalitChauhan56/PubChem.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LalitChauhan56/PubChem.jl)


PubChem.jl is a package used to fetch data from the PubChem database and attach it to species defined using the Catalyst.jl package.

## Example

Let us suppose that we want to find the chemical properties associated with the species. 

We will just need the name of the species and a pre-defined species variable to attach the appropriate metadata to:

```julia
using PubChem, Catalyst
@variables t
@species H2O(t)
@Attach_Metadata H2O
```

Now our species also holds the chemical data fetched from PubChem as it's metadata. We can query it using:

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

  
