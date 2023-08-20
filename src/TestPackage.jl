module TestPackage
using HTTP,JSON
using JSON3
using Catalyst


include("Fetch_data.jl")

export extract_properties
export get_compound

end
