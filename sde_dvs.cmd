;====================================================================
; STEP 1: INITIALIZE WORKSPACE & CLEAR CACHE
;====================================================================
(sde:clear)

;====================================================================
; STEP 2: ACTIVE SEMICONDUCTOR REGIONS 
;====================================================================
;--- Upper P+ Silicon Emitter Layer ---
(sdegeo:create-rectangle (position 0.0 0.0 0) (position 0.10 0.005 0) "Silicon" "Src_Upper_Si")

;--- Lower P+ Germanium Emitter Layer ---
(sdegeo:create-rectangle (position 0.0 0.005 0) (position 0.10 0.010 0) "Germanium" "Src_Lower_Ge")

;--- Intrinsic TFET Channel Body ---
(sdegeo:create-rectangle (position 0.10 0 0) (position 0.15 0.010 0) "Silicon" "Channel_Body")

;--- Heavily Doped N+ Drain Region ---
(sdegeo:create-rectangle (position 0.15 0 0) (position 0.25 0.010 0) "Silicon" "Drain_Body")

;====================================================================
; STEP 3: DEDICATED BIOLOGICAL CAVITY REGIONS (DIELECTRIC MODULATION)
;====================================================================
;--- Top Biosensing Pocket (Target Molecule Immobilization Zone) ---
(sdegeo:create-rectangle (position 0.10 -0.0035 0) (position 0.13 0 0) "Oxide" "Top_Bio_Cavity")

;--- Bottom Biosensing Pocket (Target Molecule Immobilization Zone) ---
(sdegeo:create-rectangle (position 0.10 0.010 0) (position 0.13 0.0135 0) "Oxide" "Bottom_Bio_Cavity")

;====================================================================
; STEP 4: HORIZONTAL HETERO-DIELECTRIC GATE OXIDE STACKS
;====================================================================
;--- Top High-k Gate Oxide Block (Hafnium Oxide) ---
(sdegeo:create-rectangle (position 0.13 -0.004 0) (position 0.15 0 0) "HfO2" "Top_Gate_Ox")

;--- Bottom High-k Gate Oxide Block (Hafnium Oxide) ---
(sdegeo:create-rectangle (position 0.13 0.010 0) (position 0.15 0.014 0) "HfO2" "Bottom_Gate_Ox")

;====================================================================
; STEP 5: THICK ALUMINUM BLOCKS FOR ELECTRICAL CONNECTIONS
;====================================================================
;--- Source Terminal Plate ---
(sdegeo:create-rectangle (position -0.005 0 0) (position 0.0 0.010 0) "Aluminum" "Contact_Source_Block")

;--- Drain Terminal Plate ---
(sdegeo:create-rectangle (position 0.25 0 0) (position 0.255 0.010 0) "Aluminum" "Contact_Drain_Block")

;--- Top Metal Gate Plate (M1 Workfunction Zone) ---
(sdegeo:create-rectangle (position 0.10 -0.006 0) (position 0.15 -0.004 0) "Aluminum" "Contact_Top_Gate_Block")

;--- Bottom Metal Gate Plate (M2 Workfunction Zone) ---
(sdegeo:create-rectangle (position 0.10 0.014 0) (position 0.15 0.016 0) "Aluminum" "Contact_Bottom_Gate_Block")

;====================================================================
; STEP 6: EXACT ELECTRICAL DOPING PROFILES
;====================================================================
;--- P+ Source Region Doping ---
(sdedr:define-refeval-window "Win_Src" "Rectangle" (position 0 0 0) (position 0.10 0.010 0))
(sdedr:define-constant-profile "Dope_Src" "Boron" 5e18)
(sdedr:define-constant-profile-placement "Place_Src" "Dope_Src" "Win_Src")

;--- Intrinsic Channel Background ---
(sdedr:define-refeval-window "Win_Chan" "Rectangle" (position 0.10 0 0) (position 0.15 0.010 0))
(sdedr:define-constant-profile "Dope_Chan" "Phosphorus" 1e15)
(sdedr:define-constant-profile-placement "Place_Chan" "Dope_Chan" "Win_Chan")

;--- N+ Drain Collector Doping ---
(sdedr:define-refeval-window "Win_Drn" "Rectangle" (position 0.15 0 0) (position 0.25 0.010 0))
(sdedr:define-constant-profile "Dope_Drn" "Phosphorus" 1e20)
(sdedr:define-constant-profile-placement "Place_Drn" "Dope_Drn" "Win_Drn")

;====================================================================
; STEP 7: VERTICAL TUNNELING JUNCTION MESH REFINEMENT
;====================================================================
;--- Dense localized grid window around X = 0.10 um to evaluate the electrostatic gating effect ---
(sdedr:define-refeval-window "Mesh_Junc_Win" "Rectangle" (position 0.098 0 0) (position 0.102 0.010 0))
(sdedr:define-mesh-multibox "Junc_Grid" "MaxElementSize" (list 0.001 0.0005 0) "MinElementSize" (list 0.0001 0.0001 0))
(sdedr:define-mesh-multibox-placement "Place_Junc_Grid" "Junc_Grid" "Mesh_Junc_Win")

;====================================================================
; STEP 8: EXECUTE STRUCTURE COMPILE MESH
;====================================================================
(sde:mesh "build" "sde_dvs")
