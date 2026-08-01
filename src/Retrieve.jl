"""
    chemical_properties(species)

Return PubChem chemical properties for a symbolic species or a PubChem query.

# Arguments
- `species`: A metadata-annotated Catalyst or ModelingToolkit symbolic species, an
  `AbstractString` compound name, or an integer PubChem CID.

# Returns
- A `Dict` of the properties returned by [`extract_properties`](@ref). Symbolic species
  are read from their attached metadata; names and CIDs are retrieved from PubChem.

# Examples
```julia
chemical_properties("water")["Molecular_formula"] # "H2O"
```
"""
chemical_properties(s::Num) = chemical_properties(Symbolics.value(s))
function chemical_properties(s::BasicSymbolic)
    return ModelingToolkit.getmetadata(s, CompoundProperties)
end
chemical_properties(x::Union{AbstractString, Integer}) = get_compound_properties(x)

"""
    molecular_weight(species)

Return the molecular weight of `species` in g/mol.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"Molecular_weight"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a molecular weight.

# Examples
```julia
molecular_weight("water") # 18.015
```
"""
function molecular_weight(s)
    return get(chemical_properties(s), "Molecular_weight") do
        error("Molecular weight not found in properties")
    end
end

"""
    IUPAC_Name_Preferred(species)

Return the preferred IUPAC name of `species`.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"IUPAC_Name_Preferred"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a preferred IUPAC name.
"""
function IUPAC_Name_Preferred(s)
    return get(chemical_properties(s), "IUPAC_Name_Preferred") do
        error("IUPAC_Name_Preferred not found in properties")
    end
end

"""
    IUPAC_Name_Traditional(species)

Return the traditional IUPAC name of `species`.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"IUPAC_Name_Traditional"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a traditional IUPAC name.
"""
function IUPAC_Name_Traditional(s)
    return get(chemical_properties(s), "IUPAC_Name_Traditional") do
        error("IUPAC_Name_Traditional not found in properties")
    end
end

"""
    molecular_formula(species)

Return the molecular formula of `species`.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"Molecular_formula"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a molecular formula.
"""
function molecular_formula(s)
    return get(chemical_properties(s), "Molecular_formula") do
        error("Molecular_formula not found in properties")
    end
end

"""
    smiles(species)

Return the SMILES representation of `species`.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"Smiles"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a SMILES string.
"""
function smiles(s)
    return get(chemical_properties(s), "Smiles") do
        error("Smiles not found in properties")
    end
end

"""
    molecular_mass(species)

Return the molecular mass of `species` in unified atomic mass units.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"Molecular_mass"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a molecular mass.
"""
function molecular_mass(s)
    return get(chemical_properties(s), "Molecular_mass") do
        error("Molecular mass not found in properties")
    end
end

"""
    charge(species)

Return the formal charge of `species`.

# Arguments
- `species`: Any value accepted by [`chemical_properties`](@ref).

# Returns
- The `"Charge"` property from PubChem.

# Throws
- `ErrorException`: The available properties do not contain a charge.
"""
charge(s::Num) = charge(Symbolics.value(s))
function charge(s)
    return get(chemical_properties(s), "Charge") do
        error("Charge not found in properties")
    end
end
