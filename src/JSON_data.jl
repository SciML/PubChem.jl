struct CompoundProperties end
Symbolics.option_to_metadata_type(::Val{:properties}) = CompoundProperties

function get_json_from_url(url; retries = 5, retry_delay = 1)
    for attempt in 1:(retries + 1)
        try
            buffer = IOBuffer()
            Downloads.download(url, buffer)
            return JSON.parse(String(take!(buffer)))
        catch err
            if err isa Downloads.RequestError &&
                    err.response.status >= 500 &&
                    attempt <= retries
                sleep(retry_delay)
            else
                rethrow()
            end
        end
    end
    return
end

# Get JSON using the name of the compound
function get_json_from_name(name)
    return get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/$name/json")
end

# Get JSON using the CID of the compound
function get_json_from_cid(cid)
    return get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/$cid/json")
end

"""
    get_compound(name::AbstractString | cid::Integer)

Retrieve PubChem's JSON compound record by name or compound identifier.

# Arguments
- `name::AbstractString`: A PubChem-recognized compound name, such as `"water"`.
- `cid::Integer`: A PubChem Compound Identifier (CID), such as `962` for water.

# Returns
- A JSON object represented by Julia dictionaries and vectors.

# Throws
- `KeyError`: The PubChem endpoint responds with HTTP 404 for `name` or `cid`.
- `Downloads.RequestError`: The request cannot be completed for another HTTP or network
  reason.

# Examples
```julia
water = get_compound(962)
properties = extract_properties(water)
properties["Molecular_formula"] # "H2O"
```
"""
function get_compound end

function get_compound(x::Integer)
    return try
        get_json_from_cid(x)
    catch err
        if err isa Downloads.RequestError && err.response.status == 404
            throw(KeyError(x))
        else
            rethrow()
        end
    end
end

function get_compound(x::AbstractString)
    return try
        get_json_from_name(x)
    catch err
        # unlike for integer key we can make a misformated URL, or a 404
        if err isa Downloads.RequestError && err.response.status == 404
            throw(KeyError(x))
        else
            rethrow()
        end
    end
end

get_compound(x::Symbol) = get_compound(String(x))

"""
    extract_properties(data)

Extract PubChem compound properties from the JSON object returned by
[`get_compound`](@ref).

# Arguments
- `data`: A compound record returned by [`get_compound`](@ref), with the PubChem PUG
  JSON layout.

# Returns
- A `Dict` whose available keys are `"IUPAC_Name_Preferred"`,
  `"IUPAC_Name_Traditional"`, `"Molecular_weight"`, `"Molecular_formula"`,
  `"Molecular_mass"`, `"Smiles"`, and `"Charge"`. PubChem omits some properties for
  some compounds, so all keys except `"Charge"` are conditional on the response.

# Examples
```julia
properties = extract_properties(get_compound("water"))
properties["IUPAC_Name_Preferred"] # "oxidane"
```
"""
function extract_properties(data)
    properties = Dict()

    # Get the information section from the JSON
    info = data["PC_Compounds"][1]["props"]

    # Extract charge information
    charge = data["PC_Compounds"][1]["charge"]

    # Iterate over the 'info' array
    for item in info
        # Get the label and name of the property
        label = get(item["urn"], "label", "")
        name = get(item["urn"], "name", "")

        # Check if the property is one of the ones we're interested in
        if label == "IUPAC Name" && name == "Preferred"
            properties["IUPAC_Name_Preferred"] = get(item, "value", "")["sval"]
        elseif label == "IUPAC Name" && name == "Traditional"
            properties["IUPAC_Name_Traditional"] = get(item, "value", "")["sval"]
        elseif label == "Molecular Weight"
            properties["Molecular_weight"] = parse(Float64, get(item, "value", "")["sval"])
        elseif label == "Molecular Formula"
            properties["Molecular_formula"] = get(item, "value", "")["sval"]
        elseif label == "Mass"
            properties["Molecular_mass"] = parse(Float64, get(item, "value", "")["sval"])
        elseif label == "SMILES"
            properties["Smiles"] = get(item, "value", "")["sval"]
        end
    end

    # Store the charge information
    properties["Charge"] = charge

    # Return the properties
    return properties
end

"""
    get_compound_properties(name::AbstractString | cid::Integer)

Returns a dictionary of chemical properties of the given compound.
"""
function get_compound_properties(name)
    compound_data = get_compound(name)
    return extract_properties(compound_data)
end

"""
    @attach_metadata species [name_or_cid]

Fetch chemical properties from PubChem and attach them as ModelingToolkit metadata to
`species`.

# Arguments
- `species`: A ModelingToolkit or Catalyst symbolic species variable.
- `name_or_cid`: Optional `AbstractString`, `Symbol`, or integer CID identifying the
  compound. When omitted, the species name is used as the PubChem query.

# Returns
- The macro expands to an assignment that replaces `species` with a metadata-annotated
  symbolic variable. The attached properties can be read with [`chemical_properties`](@ref).

# Examples
```julia
@variables t
@species H2(t)
@attach_metadata H2
chemical_properties(H2)["Molecular_formula"] # "H2"
```
"""
macro attach_metadata(variable, name)
    properties = get_compound_properties(name)
    return quote
        $(esc(variable)) = $(ModelingToolkit.setmetadata)(
            $(esc(variable)), $CompoundProperties, $properties
        )
    end
end

macro attach_metadata(variable)
    properties = get_compound_properties(variable)
    return quote
        $(esc(variable)) = $(ModelingToolkit.setmetadata)(
            $(esc(variable)), $CompoundProperties, $properties
        )
    end
end
