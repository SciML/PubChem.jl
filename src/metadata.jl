using HTTP, JSON ,Symbolics

function get_json_from_url(url)
    # Send HTTP GET request
    resp = HTTP.get(url)

    # Convert HTTP response to a string and parse it as JSON
    return JSON.parse(String(resp.body))
end

function get_json_from_name(name)
    return get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/$name/json")
end

function get_json_from_cid(cid)
    return get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/$cid/json")
end

get_compound(x::Integer) = get_json_from_cid(x)
get_compound(x::AbstractString) = get_json_from_name(x)

function extract_properties(data)
    # Extract the properties from the JSON data
    properties = Dict(
        "iupac_name_traditional" => data["PC_Compounds"][1]["props"][13]["value"]["sval"],
        "iupac_name_preferred" => data["PC_Compounds"][1]["props"][12]["value"]["sval"],
        "molecular_weight" => data["PC_Compounds"][1]["props"][18]["value"]["sval"],
        "molecular_formula" => data["PC_Compounds"][1]["props"][17]["value"]["sval"],
        "smiles" => data["PC_Compounds"][1]["props"][19]["value"]["sval"]
    )

    # Return the properties
    return properties
end

function get_compound_properties(name)
    # Fetch compound data
    compound_data = get_compound(name)

    # Extract and return properties
    return extract_properties(compound_data)
end

struct Compound
    var::Num
    metadata::Dict
end

function Compound(varname::String, compound_name::Union{String,Int})
    @variables var = Symbol(varname)

    # Fetch compound data as metadata
    metadata = get_compound_properties(compound_name)

    # Create and return Compound
    Compound(var, metadata)
end


# Carbon = Compound("C","Carbon")
# N = Compound("N", 947)
# N.var    # gives you the variable
# N.metadata  # gives you metadata dict
# N.metadata["molecular_weight"]  # gives you the molecular weight directly

# Carbon.metadata

