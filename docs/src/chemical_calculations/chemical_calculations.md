# Chemical Calculations

You can now utilize the chemical properties fetched in the previous tutorial to perform various calculations, such as determining the limiting reagent and calculating theoretical yields in a balanced Catalyst reaction.

## Determining Limiting Reagent 

As an example, let's consider the reaction `2Al + 3Cl2 --> 2AlCl3` and suppose we have the masses of `Al` and `Cl2` as 2.80g and 4.15g, respectively.

We begin by defining the species involved in the reaction and attaching metadata to them using the `@attach_metadata` macro. 

```@example ind1
using PubChem, Catalyst

# Define the species involved in the reaction
@variables t
@species Al(t), Cl2(t), AlCl3(t)

# Attach metadata to the species
@attach_metadata Al 
@attach_metadata Cl2 
@attach_metadata AlCl3 
nothing #hide
```

We then define the relevant reaction in Catalyst.
```@example ind1
# Define a balanced Catalyst reaction 
rx = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])
```
!!! note 
        The reaction should be stoichiometrically balanced.

We can then calculate the limiting reagent given the masses of the reactants.

```@example ind1
limiting_reagent(rx,[2.80,4.15])  # Returns the limiting reagent and it's number of moles
```

## Determining Theoretical Yield

Similarly if we want to calculate the theoretical yield of `AlCl3` in the above reaction we can do the following:
```@example ind1
theoretical_yield(rx,[2.80,4.15],AlCl3) # theoretical yield in grams
```

## Calculating Molar Ratios in a Reaction

We can calculate the molar ratios of two species involved in the reaction. If we want to calcuate the molar ratio of `Al` and `AlCl3` in the above reaction, we can do the following:
```@example ind1
molar_ratio(rx,Al,AlCl3)
```

## Calculating Number of moles

We can calculate the number of moles of a given species if we have it's mass. 

For example, if we want to determine the number of moles in 95g of MnO2 we can do the following:

```@example ind1
# Define the species and attach metadata
@variables t
@species MnO2(t)
@attach_metadata MnO2
nothing #hide
```

```@example ind1
moles_by_mass(MnO2,95)
```
