# Production-of-H2

This repository contains the MATLAB implementation, DWSIM process simulation, and project documentation developed for the CHE251 (Chemical Engineering Laboratory) course at IIT Kanpur.

## Overview

The objective of this project was to design and simulate a multi-stage hydrogen production plant capable of processing **7402 kg/h of wet biomass feed** into high-purity hydrogen gas.

The process combines material balance calculations, numerical solving in MATLAB, and steady-state process simulation in DWSIM to evaluate and optimize the overall plant performance.

---

## Objectives

- Design a multi-stage hydrogen production process from biomass.
- Perform degree-of-freedom analysis and material balance calculations.
- Validate process calculations using both MATLAB and DWSIM.

---

## Methodology

### MATLAB
- Developed a custom `fsolve`-based nonlinear solver.
- Solved coupled material balance equations across **22 process streams**.
- Verified convergence of the complete process flowsheet.

### DWSIM
- Simulated the complete hydrogen production process.
- Applied **Raoult's Law** for the continuous dryer.
- Modeled:
  - Water-Gas Shift (WGS) reactor with **90% conversion**
  - MDEA absorption unit for CO₂ removal

---

## Results

- Verified consistency between MATLAB calculations and DWSIM simulation.
- Achieved production of approximately **1302 kg/h of hydrogen**.
- Obtained **99.9% hydrogen purity** after process optimization.

---

## Repository Contents

| File | Description |
|------|-------------|
| `CHE251_MATLAB_code.m` | MATLAB code for nonlinear material balance calculations |
| `DWSIM_simulation.dwxmz` | Complete DWSIM process simulation |
| `TERM_REPORT_FINAL_REPORT.pdf` | Detailed project report |
| `term_project_presentation_group9.pdf` | Final project presentation |

---

## Software Requirements

- MATLAB
- DWSIM
