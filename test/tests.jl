using HTTP, JSON
# Define the PubChem CID of the species you want to fetch data for
cid = 962

# Fetch the PubChem data for the species
url = "https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/962/property/MolecularFormula,MolecularWeight,InChIKey,Charge/json"
response = HTTP.request("GET", url)
data = JSON.parse(String(response.body))

# for i in data
#     println(i)
# end

properties = data["PropertyTable"]["Properties"]
cid_value = properties[1]["CID"]
formula_value = properties[1]["MolecularFormula"]
weight_value = properties[1]["MolecularWeight"]
charge_value = properties[1]["Charge"]

# Print the extracted values
println("CID: $cid_value")
println("Formula: $formula_value")
println("Weight: $weight_value")
println("Charge: $charge_value")




# # Extract the relevant data from the PubChem response
# molecular_formula = data["Properties"]["MolecularFormula"]["Value"]
# molecular_weight = data["Properties"]["MolecularWeight"]["Value"]

# # Create a new Species object with the fetched data
# sp = Species("my_species", formula=molecular_formula, mw=molecular_weight)

# # Print the species information
# println("Name: $(sp.formula)")
# println("Molecular weight: $(sp.mw)")

# using HTTP, JSON

# cid = 962

# url = "https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/962/json"
# response = HTTP.request("GET", url)
# data = JSON.parse(String(response.body))

# # props = data["PC_Compounds"][1]

# # props = data["PC_Compounds"][0]["props"]


using HTTP, JSON

# Send a GET request to the PubChem API
response = HTTP.get("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/963/json")

# Parse the JSON response
data = JSON.parse(String(response.body))

# Extract the molecular weight from the JSON data
molecular_weight = data["PC_Compounds"][1]["props"][18]["value"]["sval"]
molecular_formula = data["PC_Compounds"][1]["props"][17]["value"]["sval"]


println("Molecular weight: ", molecular_weight)
println("Molecular Formula ", molecular_formula)

using HTTP,JSON

function extract_properties(name)
    # Send a GET request to the PubChem API
    response = HTTP.get("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/$name/json")
  
    # Parse the JSON response
    data = JSON.parse(String(response.body))
  
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

  extract_properties("benzene")

