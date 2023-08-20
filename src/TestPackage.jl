module TestPackage
using HTTP
using JSON
using Catalyst

include("Fetch_data.jl")

export extract_properties
export get_compound

end
