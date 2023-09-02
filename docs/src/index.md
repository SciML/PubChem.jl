# [PubChem.jl] (@id index)

PubChem.jl is a powerful Julia package that facilitates easy access to chemical data from the PubChem database and associates it with chemical species defined using the Catalyst.jl package. This allows you to seamlessly integrate chemical metadata into your computational workflows.

## Features
- Effortlessly retrieve chemical information from the PubChem database using the PubChem REST API.
- Determine the molar ratios, liming reagent and theoritical yield in a chemical reaction.
- Calculate the number of moles of a compound.

## Installation

PubChem can be installed through the Julia package manager:

```julia
using Pkg
Pkg.add("PubChem")
```

## Illustrative Example

To retrieve chemical properties for the compound `H2O`, begin by defining the compound as you would in Catalyst and then attach the relevant metadata:

```@example ind1
using PubChem, Catalyst
@variables t
@species H2O(t)
@attach_metadata H2O
```

Now, our species `H2O` contains chemical data retrieved from PubChem as its metadata. To access and query this data, you can utilize the following method:

```@example ind1
properties(H2O)
```
