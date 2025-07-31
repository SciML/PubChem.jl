# [Querying Properties](@id querying_data)

You can query properties from PubChem using the [`chemical_properties`](@ref) which returns a dictionary, or any of the specific functions like [`molecular_weight`](@ref) etc.
These take either a CID, a name, a formula or a species in Catalyst that you have attached metadata to in advance.

## Catalyst Metadata example

For this example, let us begin by attaching metadata to a species.

```@example ind1
using PubChem, Catalyst

# Define the species and attach metadata
@variables t
@species CH3COOH(t)
@attach_metadata CH3COOH
nothing #hide
```

To get all the chemical properties attached to the species, we can use:

```@example ind1
chemical_properties(CH3COOH)
```

To get the molecular weight of the species, we can use:

```@example ind1
molecular_weight(CH3COOH)
```

To get the molecular formula of the species, we can use:

```@example ind1
molecular_formula(CH3COOH)
```

To get the molecular mass of the species, we can use:

```@example ind1
molecular_mass(CH3COOH)
```

To get the charge on the species, we can use:

```@example ind1
charge(CH3COOH)
```

To get the SMILES of the species, we can use:

```@example ind1
smiles(CH3COOH)
```

To get the preferred IUPAC name of the species, we can use:

```@example ind1
IUPAC_Name_Preferred(CH3COOH)
```

To get the traditional IUPAC name of the species, we can use:

```@example ind1
IUPAC_Name_Traditional(CH3COOH)
```

## Querying Directly

All of the above methods work with named, CIDs, or formula as well.

```@example direct_query
using PubChem
chemical_properties("water")
```

```@example direct_query
chemical_properties("oxidane")
```

```@example direct_query
chemical_properties(962)
```

```@example direct_query
chemical_properties("H2O")
```
