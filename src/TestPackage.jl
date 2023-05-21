module TestPackage
using HTTP,JSON
using JSON3

function extract_properties(data)
    # Extract the properties from the JSON data
    properties = Dict(
        "molecular_weight" => data["PC_Compounds"][1]["props"][18]["value"]["sval"],
        "molecular_formula" => data["PC_Compounds"][1]["props"][17]["value"]["sval"],
        "inchi" => data["PC_Compounds"][1]["props"][20]["value"]["sval"],
        "smiles" => data["PC_Compounds"][1]["props"][19]["value"]["sval"],
    )

    # Return the properties
    return properties
end

get_resp_from_name(name) = HTTP.get("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/$name/json")
get_json_from_resp(resp) = JSON.parse(String(resp.body))
get_json_from_name(name) = get_json_from_resp(get_resp_from_name(name))


get_resp_from_cid(cid) = HTTP.get("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/$cid/json")
get_json_from_cid(cid) = get_json_from_resp(get_resp_from_cid(cid))

get_compound(x::Integer) = get_json_from_cid(x)
get_compound(x::AbstractString) = get_json_from_name(x)

export extract_properties
export get_compound

end
