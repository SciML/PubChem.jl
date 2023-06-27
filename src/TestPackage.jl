module TestPackage
using HTTP,JSON
using JSON3
using LinearAlgebra
using Metadata

include("metadata.jl")
include("testbalance.jl")

export get_compound_properties
export Compound
export balance_reaction
export parse_formula

end
