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
        # Other packages' non-public names used qualified in the source.
        all_qualified_accesses_are_public = (;
            ignore = (
                :fast_scalar_indexing,    # ArrayInterface
                :get,                     # HTTP (extends Base.get)
                :option_to_metadata_type, # Symbolics
                :parse,                   # JSON
                :value,                   # ModelingToolkit
            ),
        ),
        # SymbolicUtils.BasicSymbolic is not declared public.
        all_explicit_imports_are_public = (; ignore = (:BasicSymbolic,)),
    ),
)
