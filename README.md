# SDG-DMTFET-Dual-Sensor
Sentaurus TCAD simulation files and OriginPro plots for a Split-Source Double-Gate Dielectric-Modulated TFET optimized for Biosensing and Photosensing applications.

# SDG-DMTFET Dual-Sensor Simulation Project

This repository contains the Synopsys Sentaurus TCAD simulation scripts for a **Split-Source Double-Gate Dielectric-Modulated Tunnel Field-Effect Transistor (SSDG-DMTFET)** optimized for high-performance dual-mode sensing applications.

## Core Simulation Files

### 1. `sde_dvs.cmd` (Structure Generation Deck)
* **Description:** This file contains the foundational geometric architecture and material parameters for the device configured as a **Biosensor**.
* **Technical Highlights:**
  * Defines a **heterojunction split-source region** using a stacked architecture of $P^+$ Silicon over a low-bandgap $P^+$ Germanium layer ($0.7\text{ eV}$) to significantly enhance Band-to-Band Tunneling (BTBT) carrier injection efficiency.
  * Carves out **symmetrical dual-nanogap cavities ($3.5\text{ nm}$ thick)** directly above and below the channel region, designated as biological immobilization zones for targeted analytes.
  * Implements a **sub-nanometer localized multi-box mesh refinement** across the critical $X = 0.10\ \mu\text{m}$ source-channel junction plane to ensure the device simulator captures highly accurate electrostatic gating and quantum tunneling behavior without compiling errors.

### 2. `sdevice_des.cmd` (Operational Physics & Simulation Sweep Deck)
* **Description:** This command file handles the physical simulation environment, numerical convergence algorithms, and the bias conditions required to test the performance of the biosensor structure.
* **Technical Highlights:**
  * Activates advanced **non-local path mesh models** to dynamically calculate quantum mechanical band bending and carrier tunneling rates across the Si/Ge interface.
  * Sets up essential semiconductor transport mechanisms including **Concentration-Dependent Mobility (DopingDep)**, High-Field Velocity Saturation, and Shockley-Read-Hall (SRH) plus Auger recombination models.
  * Executes a two-stage **Quasistatic solver loop**: first fixing the Drain collector bias ($V_{\text{DS}} = 0.5\text{ V}$), and then sweeping the Gate electrode ($V_{\text{GS}} = 0\text{ V}$ to $1.5\text{ V}$) to output the raw electrical data logs (`.plt` files) used for evaluating device sensitivity ($S_n$).
