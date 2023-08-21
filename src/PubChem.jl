module PubChem
using HTTP
using JSON
using Catalyst

include("JSON_data.jl")
include("Chemistry_functions.jl")
include("Retrieve.jl")

export get_compound
export extract_properties
export @Attach_Metadata

export molar_ratio, moles_by_mass , moles_by_volume
export limiting_reagent, theoretical_yield

export properties, molecular_weight
export molecular_formula, molecular_mass
export IUPAC_Name_Preferred, IUPAC_Name_Traditional
export smiles, charge

end
