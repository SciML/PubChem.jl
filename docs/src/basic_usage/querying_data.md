# [Querying Properties](@id querying_data)

Once we have attached the properties to our species using the `@attach_metadata` macro, we can query them using pre-defined functions.

Let us begin by attaching metadata to a species.

```@example ind1
using PubChem, Catalyst

# Define the species involved in the reaction and attach metadata
@variables t
@species CH3COOH(t)
@attach_metadata CH3COOH
nothing #hide
```

To get all the chemical properties attached to the species we can use:

```@example ind1
chemical_properties(CH3COOH)
```

To get the molecular weight of the species we can use:

```@example ind1
molecular_weight(CH3COOH)
```

To get the molecular formula of the species we can use:

```@example ind1
molecular_formula(CH3COOH)
```

To get the molecular mass of the species we can use:
```@example ind1
molecular_mass(CH3COOH)
```

To get the charge on the species we can use:
```@example ind1
charge(CH3COOH)
```

To get the SMILES of the species we can use:
```@example ind1
smiles(CH3COOH)
```

To get the preferred IUPAC name the species we can use:
```@example ind1
IUPAC_Name_Preferred(CH3COOH)
```

To get the traditional IUPAC namethe species we can use:
```@example ind1
IUPAC_Name_Traditional(CH3COOH)
```
