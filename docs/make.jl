using Documenter, PubChem, Catalyst

docpath = Base.source_dir()
assetpath = joinpath(docpath, "src", "assets")
cp(joinpath(docpath, "Manifest.toml"), joinpath(assetpath, "Manifest.toml"), force = true)
cp(joinpath(docpath, "Project.toml"), joinpath(assetpath, "Project.toml"), force = true)


include("pages.jl")

makedocs(sitename = "PubChem.jl",
         authors = "Samuel Isaacson",
         format = Documenter.HTML(; analytics = "UA-90474609-3",
                                  prettyurls = (get(ENV, "CI", nothing) == "true"),
                                  assets = ["assets/favicon.ico"],
                                  canonical = "https://LalitChauhan56.github.io/PubChem.jl"),
         modules = [PubChem, Catalyst],
         doctest = false,
         clean = true,
         pages = pages)
       
deploydocs(repo="github.com/LalitChauhan56/PubChem.jl.git",
)
