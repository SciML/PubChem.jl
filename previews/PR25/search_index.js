var documenterSearchIndex = {"docs":
[{"location":"basic_usage/attach_metadata_macro/#attach_metadata_macro","page":"Attaching Metadata","title":"Attaching Metadata","text":"","category":"section"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"In this tutorial we provide an introduction to using PubChem.jl to attach chemical properties as metadata to species defined using the Catalyst package.","category":"page"},{"location":"basic_usage/attach_metadata_macro/#Basic-Syntax","page":"Attaching Metadata","title":"Basic Syntax","text":"","category":"section"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"We first import the basic packages we'll need:","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"# If not already installed, first hit \"]\" within a Julia REPL. Then type:\n# add PubChem Catalyst \n\nusing PubChem, Catalyst","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"We now start by defining our species using the @species macro from Catalyst.","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"@variables t\n@species HCl(t)\nnothing # hide","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"Now we attach the chemical properties fetched from PubChem using the attach_metadata macro.","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"@attach_metadata HCl\nnothing # hide","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"The attach_metadata macro queries the PubChem database and attaches the appropriate chemical properties to our species. We can now retrieve the chemical properties:","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"chemical_properties(HCl)","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"In some cases, we may wish to assign chemical properties to a species with a custom name. In such cases, we can use the IUPAC name of the species. ","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"using PubChem, Catalyst\n\n@variables t\n@species X(t)\n@attach_metadata X \"H2O\"\nnothing # hide","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"The chemical properties of H2O have now been attached to X.","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"chemical_properties(X)","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"Similary, we can use the CID of the species when the name of the species is complex or difficult to work with. ","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"using PubChem, Catalyst\n\n@variables t\n@species Y(t)\n@attach_metadata Y 6506 #CID of triethyl 2-hydroxypropane-1,2,3-tricarboxylate\nnothing # hide","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"The chemical properties of triethyl 2-hydroxypropane-1,2,3-tricarboxylate have now been attached to Y.","category":"page"},{"location":"basic_usage/attach_metadata_macro/","page":"Attaching Metadata","title":"Attaching Metadata","text":"chemical_properties(Y)","category":"page"},{"location":"basic_usage/querying_data/#querying_data","page":"Querying Properties","title":"Querying Properties","text":"","category":"section"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"You can query properties from PubChem using the chemical_properties which returns a dictionary, or any of the specific functions like molecular_weight etc. These take either a CID, a name, a formula or a species in Catalyst that you have attached metadata to in advance.","category":"page"},{"location":"basic_usage/querying_data/#Catalyst-Metadata-example","page":"Querying Properties","title":"Catalyst Metadata example","text":"","category":"section"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"For this example, let us begin by attaching metadata to a species.","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"using PubChem, Catalyst\n\n# Define the species and attach metadata\n@variables t\n@species CH3COOH(t)\n@attach_metadata CH3COOH\nnothing #hide","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get all the chemical properties attached to the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"chemical_properties(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the molecular weight of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"molecular_weight(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the molecular formula of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"molecular_formula(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the molecular mass of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"molecular_mass(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the charge on the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"charge(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the SMILES of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"smiles(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the preferred IUPAC name of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"IUPAC_Name_Preferred(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"To get the traditional IUPAC name of the species, we can use:","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"IUPAC_Name_Traditional(CH3COOH)","category":"page"},{"location":"basic_usage/querying_data/#Querying-Directly","page":"Querying Properties","title":"Querying Directly","text":"","category":"section"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"All of the above methods work with named, CIDs, or formula as well.","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"using PubChem\nchemical_properties(\"water\")","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"chemical_properties(\"oxidane\")","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"chemical_properties(962)","category":"page"},{"location":"basic_usage/querying_data/","page":"Querying Properties","title":"Querying Properties","text":"chemical_properties(\"H2O\")","category":"page"},{"location":"chemical_calculations/chemical_calculations/#chemical_calculations","page":"Chemical Calculations","title":"Chemical Calculations","text":"","category":"section"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"You can now utilize the chemical properties fetched in the previous tutorial to perform various calculations, such as determining the limiting reagent and calculating theoretical yields in a balanced Catalyst reaction.","category":"page"},{"location":"chemical_calculations/chemical_calculations/#Determining-Limiting-Reagent","page":"Chemical Calculations","title":"Determining Limiting Reagent","text":"","category":"section"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"As an example, let's consider the reaction 2Al + 3Cl2 --> 2AlCl3 and suppose we have the masses of Al and Cl2 as 2.80g and 4.15g, respectively.","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We begin by defining the species involved in the reaction and attaching metadata to them using the @attach_metadata macro. ","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"using PubChem, Catalyst\n\n# Define the species involved in the reaction\n@variables t\n@species Al(t), Cl2(t), AlCl3(t)\n\n# Attach metadata to the species\n@attach_metadata Al \n@attach_metadata Cl2 \n@attach_metadata AlCl3 \nnothing #hide","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We then define the relevant reaction in Catalyst.","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"# Define a balanced Catalyst reaction \nrx = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"note: Note\nThe chemical reaction should be balanced.","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We can then calculate the limiting reagent, provided we have the masses of the reactants.","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"limiting_reagent(rx,[2.80,4.15])  # Returns the limiting reagent and it's number of moles","category":"page"},{"location":"chemical_calculations/chemical_calculations/#Determining-Theoretical-Yield","page":"Chemical Calculations","title":"Determining Theoretical Yield","text":"","category":"section"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"Similarly if we want to calculate the theoretical yield of AlCl3 in the above reaction, we can do the following:","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"theoretical_yield(rx,[2.80,4.15],AlCl3) # theoretical yield in grams","category":"page"},{"location":"chemical_calculations/chemical_calculations/#Calculating-Molar-Ratios-in-a-Reaction","page":"Chemical Calculations","title":"Calculating Molar Ratios in a Reaction","text":"","category":"section"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We can calculate the molar ratios of two species involved in a reaction. If we want to calcuate the molar ratio of Al and AlCl3 in the above reaction, we can do the following:","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"molar_ratio(rx,Al,AlCl3)","category":"page"},{"location":"chemical_calculations/chemical_calculations/#Calculating-Number-of-Moles","page":"Chemical Calculations","title":"Calculating Number of Moles","text":"","category":"section"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We can calculate the number of moles of a given species if we have its mass. ","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"For example, if we want to determine the number of moles in 95g of MnO2 we can do the following:","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"# Define the species and attach metadata\n@variables t\n@species MnO2(t)\n@attach_metadata MnO2\nnothing #hide","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"moles_by_mass(MnO2,95)","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"We can also calculate the number of moles of a species if we are given the molarity and volume of the solution.","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"For example, if we want to calculate the number of moles of MnO2 contained in 0.300L of 0.400 mol/L MnO2 Solution, we can do the following:","category":"page"},{"location":"chemical_calculations/chemical_calculations/","page":"Chemical Calculations","title":"Chemical Calculations","text":"moles_by_volume(0.300,0.400)","category":"page"},{"location":"#index","page":"Home","title":"PubChem.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"PubChem.jl is a powerful Julia package that facilitates easy access to chemical data from the PubChem database and associates it with chemical species defined using the Catalyst.jl package. This allows you to seamlessly integrate chemical metadata into your computational workflows.","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Effortlessly retrieve chemical information from the PubChem database using the PubChem REST API.\nDetermine the molar ratios, limiting reagent and theoretical yield in a chemical reaction.\nCalculate the number of moles of a compound.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"PubChem can be installed through the Julia package manager:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Pkg\nPkg.add(\"PubChem\")","category":"page"},{"location":"#Illustrative-Example","page":"Home","title":"Illustrative Example","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To retrieve chemical properties for the compound H2O, begin by defining the compound as you would in Catalyst and then attach the relevant metadata:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using PubChem, Catalyst\n@variables t\n@species H2O(t)\n@attach_metadata H2O","category":"page"},{"location":"","page":"Home","title":"Home","text":"Now, our species H2O contains chemical data retrieved from PubChem as its metadata. To access and query this data, you can utilize the following method:","category":"page"},{"location":"","page":"Home","title":"Home","text":"chemical_properties(H2O)","category":"page"}]
}