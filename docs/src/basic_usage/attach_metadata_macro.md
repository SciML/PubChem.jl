# [Attaching Metadata](@id attach_metadata_macro)

In this tutorial we provide an introduction to using PubChem.jl to attach chemical properties as metadata to species defined using the Catalyst package.

## Basic Syntax

We first import the basic packages we'll need:

```@example ind1
# If not already installed, first hit "]" within a Julia REPL. Then type:
# add PubChem Catalyst 

using PubChem, Catalyst
```

We now start by defining our species using the `@species` macro from Catalyst.

```@example ind1
@variables t
@species HCl(t)
nothing # hide
```

Now we attach the chemical properties fetched from PubChem using the `attach_metadata` macro.

```@example ind1
@attach_metadata HCl
nothing # hide
```

The `attach_metadata` macro queries the PubChem database and attaches the appropriate chemical properties to our species. We can now retrieve the chemical properties:

```@example ind1
chemical_properties(HCl)
```

In some cases, we may wish to assign chemical properties to a species with a custom name. In such cases, we can use the IUPAC name of the species. 

```@example ind2
using PubChem, Catalyst

@variables t
@species X(t)
@attach_metadata X "H2O"
nothing # hide
```

The chemical properties of `H2O` have now been attached to `X`.

```@example ind2
chemical_properties(X)
```

Similary, we can use the CID of the species when the name of the species is complex or difficult to work with. 

```@example ind3
using PubChem, Catalyst

@variables t
@species Y(t)
@attach_metadata Y 6506 #CID of triethyl 2-hydroxypropane-1,2,3-tricarboxylate
nothing # hide
```
The chemical properties of `triethyl 2-hydroxypropane-1,2,3-tricarboxylate` have now been attached to `Y`.

```@example ind3
chemical_properties(Y)
```