File {
  Grid    = "@tdr@"
  Current = "@plot@"
  Plot    = "@node@_des"
}

Electrode {
  { Name="source"    Voltage=0.0 }
  { Name="drain"     Voltage=0.0 }
  { Name="gate_m1"   Voltage=0.0 }
  { Name="gate_m2"   Voltage=0.0 }
}

Physics {
  HydroRefinement
  Mobility( DopingDep HighFieldSat Enormal )
  Recombination( SRH Auger )
  BandGapNarrowing( Slotboom )
  
  ; Non-Local Band-to-Band Tunneling Model
  NonLocalPath(
    Name= "Tunneling_Junction"
    Region= [ "Src_Upper_Si" "Src_Lower_Ge" "Channel_Body" ]
    Direction= X
  )
}

Plot {
  ElectrostaticPotential
  SpaceCharge eDensity hDensity
  TotalCurrent ElectronCurrent HoleCurrent
}

Solve {
  Poisson
  Coupled { Poisson Electron Hole }
  
  ; Fix Drain Bias to 0.5V
  Quasistatic (
    Increment=0.05 MaxStep=0.05
    Goal { Name="drain" Voltage=0.5 }
  ) { Coupled { Poisson Electron Hole } }
  
  ; Sweep Gate Voltage from 0V to 1.5V for Biosensor Curves
  Quasistatic (
    Increment=0.05 MaxStep=0.05
    Goal { Name="gate_m1" Voltage=1.5 }
  ) { Coupled { Poisson Electron Hole } }
}
