using SciMLTesting
using PubChem
using JET
using Test

run_qa(
    PubChem;
    explicit_imports = true,
    ei_kwargs = (;
        # `get` resolves to Base (HTTP extends Base.get with its request methods);
        # `value` is re-exported by ModelingToolkit from Symbolics.
        all_qualified_accesses_via_owners = (; ignore = (:get, :value)),
        # `get` is not declared public by HTTP (a non-SciML dep); `value` is not
        # declared public by ModelingToolkit (a re-export of a Symbolics internal).
        all_qualified_accesses_are_public = (; ignore = (:get, :value)),
    ),
)
