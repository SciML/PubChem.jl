using  Catalyst, HTTP, JSON, Test, SafeTestsets ,PubChem

# Test molar_ratio functionality
let 
    @variables t
    @species Al(t), Cl2(t), AlCl3(t)

    @Attach_Metadata Al 
    @Attach_Metadata Cl2 
    @Attach_Metadata AlCl3 

    reaction = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

    @test molar_ratio(reaction,Al,AlCl3) == 1/1
    @test molar_ratio(reaction,Al,Cl2) == Rational(2//3)
    @test molar_ratio(reaction,AlCl3,Cl2) == Rational(2//3)
end

#Test functionality to calculate number of moles
let 
    @variables t
    @species MnO2(t)

    @Attach_Metadata MnO2

    #Given mass of MnO2 = 95g (https://byjus.com/number-of-moles-formula/)
    @test moles_by_mass(MnO2,95) == 1.0927453213246374

    #Given 0.300 L of 0.400 mol/L of NaCl solution
    @test moles_by_volume(0.300,0.400) == 0.120

end

#Test functionality to calculate the limiting reagent and theoretical yield
# https://rb.gy/3zcvh
let 
    @variables t
    @species Al(t), Cl2(t), AlCl3(t)

    @Attach_Metadata Al 
    @Attach_Metadata Cl2 
    @Attach_Metadata AlCl3 

    reaction = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

    #Get limiting reagent given the masses of the reactants
    @test limiting_reagent(reaction,[2.80,4.15]) == (Cl2, 0.05853314527503526)
end

let 
    @variables t
    @species Al(t), Cl2(t), AlCl3(t)

    @Attach_Metadata Al 
    @Attach_Metadata Cl2 
    @Attach_Metadata AlCl3 

    reaction = Reaction(1.0, [Al, Cl2], [AlCl3], [2, 3], [2])

    #Calculate theoretical yield given the masses of the reactants and the product for which to calculate
    @test theoretical_yield(reaction,[2.80,4.15],AlCl3) == 5.203206393982134
end
