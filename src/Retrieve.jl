"""
    properties(x::Num)

Return the PubChem properties attached to the species.
"""

properties(s::Num) = properties(ModelingToolkit.value(s))
function properties(s)
    ModelingToolkit.getmetadata(s, CompoundProperties)
end

"""
    molecular_weight(x::Num)

Return the molecular weight of the species.
"""

molecular_weight(s::Num) = molecular_weight(ModelingToolkit.value(s))
function molecular_weight(s)
    return get(properties(s), "Molecular_weight") do
        error("Molecular weight not found in properties")
    end
end

"""
    IUPAC_Name_Preferred(x::Num)

Return the preferred IUPAC name of the species.
"""

IUPAC_Name_Preferred(s::Num) = IUPAC_Name_Preferred(ModelingToolkit.value(s))
function IUPAC_Name_Preferred(s)
    return get(properties(s), "IUPAC_Name_Preferred") do
        error("IUPAC_Name_Preferred not found in properties")
    end
end

"""
IUPAC_Name_Traditional(x::Num)

Return the traditional IUPAC name of the species.
"""

IUPAC_Name_Traditional(s::Num) = IUPAC_Name_Traditional(ModelingToolkit.value(s))
function IUPAC_Name_Traditional(s)
    return get(properties(s), "IUPAC_Name_Traditional") do
        error("IUPAC_Name_Traditional not found in properties")
    end
end

"""
    molecular_formula(x::Num)

Return the molecular formula of the species.
"""

molecular_formula(s::Num) = molecular_formula(ModelingToolkit.value(s))
function molecular_formula(s)
    return get(properties(s), "Molecular_formula") do
        error("Molecular_formula not found in properties")
    end
end

"""
    smiles(x::Num)

Return the SMILES of the species.
"""

smiles(s::Num) = smiles(ModelingToolkit.value(s))
function smiles(s)
    return get(properties(s), "Smiles") do
        error("Smiles not found in properties")
    end
end

"""
    molecular_mass(x::Num)

Return the molecular mass of the species.
"""

molecular_mass(s::Num) = molecular_mass(ModelingToolkit.value(s))
function molecular_mass(s)
    return get(properties(s), "Molecular_mass") do
        error("Molecular mass not found in properties")
    end
end

"""
    charge(x::Num)

Return the charge on the species.
"""

charge(s::Num) = charge(ModelingToolkit.value(s))
function charge(s)
    return get(properties(s), "Charge") do
        error("Charge not found in properties")
    end
end
