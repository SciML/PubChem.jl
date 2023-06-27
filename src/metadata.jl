using HTTP, JSON ,Metadata

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
        "inchi" => data["PC_Compounds"][1]["props"][20]["value"]["sval"],
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


function attach_compound_properties(variable_name::String, compound_name::AbstractString)
    # Convert string to symbol
    variable_symbol = Symbol(variable_name)

    # Fetch compound data
    compound_data = get_compound(compound_name)
  
    # Extract the properties
    properties = extract_properties(compound_data)
    
    # Attach metadata to the variable name
    Metadata.attach_metadata(variable_symbol, properties)

end

# N = attach_compound_properties("N","Nitrogen")

# Metadata.metadata(N)
