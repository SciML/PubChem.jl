# Tests for JSON retrieval

# Test that the functions return similar values
let 
    a = get_compound(962)
    b = get_compound("water")
    @test a == b

    @test get_json_from_url("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/water/json") isa Dict
    @test get_json_from_name("water") isa Dict
    @test get_json_from_cid(962) isa Dict  

    @test get_json_from_name("water") == get_json_from_cid(962)
end

let 
    get_compound_properties("Water") isa Dict
    get_compound_properties(962) isa Dict
    @test get_compound_properties("Water") == get_compound_properties(962)
end

# Check if function correctly fetches data from the JSON
let 
    data = get_json_from_name("Carbon")
    @test extract_properties(data) isa Dict

    x = Dict{Any, Any}(
        "IUPAC_Name_Preferred"   => "carbon",
        "IUPAC_Name_Traditional" => "carbon",
        "Charge"                 => 0,
        "Molecular_formula"      => "C",
        "Molecular_mass"         => 12.0,
        "Molecular_weight"       => 12.011,
        "Smiles"                 => "[C]"
    )
    
    @test x == extract_properties(data)
end

#Check that the metadata is correctly attached and accessible
let 
    @variables t
    @species H(t)
    @Attach_Metadata H

    @test properties(H) isa Dict
    @test IUPAC_Name_Preferred(H) == "molecular hydrogen"
    @test IUPAC_Name_Traditional(H) == "molecular hydrogen"
    @test charge(H) == 0
    @test molecular_formula(H) == "H2"
    @test molecular_mass(H) == 2.0156500638
    @test molecular_weight(H) == 2.016
    @test smiles(H) == "[HH]"
end

let 
    @variables t
    @species X(t)

    @Attach_Metadata X "H2O"
    a = properties(X) 

    @Attach_Metadata X 962
    b = properties(X) 

    @test a == b

    @test properties(X) isa Dict
    @test IUPAC_Name_Preferred(X) == "oxidane"
    @test IUPAC_Name_Traditional(X) == "water"
    @test charge(X) == 0
    @test molecular_formula(X) == "H2O"
    @test molecular_mass(X) == 18.010564683
    @test molecular_weight(X) == 18.015
    @test smiles(X) == "O"
end
