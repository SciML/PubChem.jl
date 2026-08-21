module PubChem
using Downloads: Downloads
using JSON: JSON
using Catalyst: Catalyst, Reaction
using ModelingToolkit: ModelingToolkit
using PrecompileTools: @compile_workload, @setup_workload
using Symbolics: Symbolics, Num
using SymbolicUtils: BasicSymbolic
using ArrayInterface: ArrayInterface

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

@setup_workload begin
    @compile_workload begin
        Symbolics.@variables x
        x = ModelingToolkit.setmetadata(
            x, CompoundProperties,
            Dict(
                "Molecular_weight" => 18.015,
                "Molecular_formula" => "H2O",
                "Charge" => 0,
            ),
        )
        molecular_weight(x)
        molecular_formula(x)
        moles_by_mass(x, 18.015)
        moles_by_volume(0.4, 0.3)
    end
end

end
