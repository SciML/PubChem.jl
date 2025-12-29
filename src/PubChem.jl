module PubChem
using HTTP: HTTP
using JSON: JSON
using Catalyst: Catalyst, Reaction
using ModelingToolkit: ModelingToolkit
using Symbolics: Symbolics, Num
using SymbolicUtils: BasicSymbolic

include("JSON_data.jl")
include("Chemistry_functions.jl")
include("Retrieve.jl")

export get_compound
export extract_properties
export @attach_metadata

export molar_ratio, moles_by_mass, moles_by_volume
export limiting_reagent, theoretical_yield

export chemical_properties, molecular_weight
export molecular_formula, molecular_mass
export IUPAC_Name_Preferred, IUPAC_Name_Traditional
export smiles, charge

end
