# Test parse_formula
formula1 = parse_formula("H2O")
@test formula1 == Dict("H" => 2, "O" => 1)

formula2 = parse_formula("C6H12O6")
@test formula2 == Dict("C" => 6, "H" => 12, "O" => 6)

formula3 = parse_formula("SiCl4")
@test formula3 == Dict("Si" => 1, "Cl" => 4)


# Test balance_reaction
reaction1 = balance_reaction("H2 + O2 → H2O")
@test reaction1 == "2H2 + 1O2 → 2H2O"

reaction2 = balance_reaction("C + O2 → CO2")
@test reaction2 == "1C + 1O2 → 1CO2"

reaction3 = balance_reaction("CO2 + H2O → C6H12O6 + O2")
@test reaction3 == "6CO2 + 6H2O → 1C6H12O6 + 6O2"

reaction4 = balance_reaction("SiCl4 + H2O → H4SiO4 + HCl")
@test reaction4 == "1SiCl4 + 4H2O → 1H4SiO4 + 4HCl"

reaction5 = balance_reaction("H2 + Cl2 → HCl")
@test reaction5 == "1H2 + 1Cl2 → 2HCl"

