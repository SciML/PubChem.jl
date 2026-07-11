using SciMLTesting
using PubChem
using JET
using Test

run_qa(
    PubChem;
    explicit_imports = true,
    ei_kwargs = (;
        # HTTP.get is the public HTTP request API, but Base.which reports Base.get
        # as the generic function owner.
        all_qualified_accesses_via_owners = (; ignore = (:get,)),
    ),
    api_docs_kwargs = (; rendered = true),
)
