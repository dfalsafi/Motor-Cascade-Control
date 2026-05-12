# DC Motor Cascade Control System

## Overview
This repository contains the design, simulation, and analysis of a multi-loop cascade control system for a DC motor. This cascaded topology is widely used in modern motor drives and Field-Oriented Control (FOC) systems. The project was developed using **MATLAB** for control gain calculations and **Simulink** for system modeling and dynamic response simulation.

## System Dynamics & Plant Model
The DC motor model connects the electrical and mechanical systems together. The plant transfer functions act as low-pass filters due to the electrical properties (resistance and inductance) and mechanical properties (moment of inertia and viscous friction).

**1. Electrical System:**
The electrical dynamics are governed by the armature voltage equation:

**Va = Ea + L(di/dt) + iR**

where Va is the armature terminal voltage, i is the armature current, R is the armature resistance, L is the inductance, and Ea is the back-electromotive force.

**2. Mechanical System:**
The mechanical dynamics are governed by Newton's second law for rotation:

**τ_em = τ_l + J(dω/dt) + Bω**

where τ_em is the electromagnetic torque, τ_l is the applied load torque, J is the moment of inertia, B is the viscous friction coefficient, and ω is the rotor speed.

**3. Electromechanical Coupling:**
The electrical and mechanical domains are bridged using two equal coefficients: the torque constant (kt) and the back-emf constant (ke). In standard SI units, their values are equivalent (ke = kt). 

![DC Motor Electromechanical Interconnections](Visual Relating Mechanical System Dynamics to Electrical System Design/coupling_diagram.png)

This coupling relationship is visually displayed in the diagram. The mechanical and electrical system differential equations are shown stacked, with interconnecting loops and triangular gain blocks representing the torque constant (k_t) and back-emf constant (k_e).

**Torque Equation:**
**τ_em = kt * i**
*(where i is the armature current)*

**Back-EMF Equation:**
**Ea = ke * ω**
*(where Ea is the induced electromotive force)*

**MATLAB and Simulink** were used to show this control design and implement the PI controller model, allowing for an accurate simulation of the system's combined electromechanical response.

## Control Architecture
The system utilizes a nested cascaded control topology, which allows for precise and stable control:
* **Inner Loop (Current Controller):** Regulates the motor's phase currents. Because the electrical dynamics are fast, this inner loop is designed to operate at a much **faster sampling rate** and higher bandwidth.
* **Outer Loop (Speed Controller):** Regulates the rotor's speed and operates at a **slower sampling rate**. This cascaded topology allows the outer speed controller to calculate a torque command, which it then passes as a reference to the inner current controller.

## DC Motor Parameters
The controllers were designed and simulated based on the following physical parameters of the DC motor:
* **Armature resistance (R):** 1 Ω
* **Armature inductance (L):** 4 mH
* **Torque/Back-emf constant (kt = ke):** 0.1 Nm/A 
* **Rotational inertia (J):** 200μ kg·m²
* **Coefficient of viscous friction (B):** 500μ kg·m²·s

## Project Structure
* **`P1_Current_PI_Controller` (Inner Loop):** Design of the high-speed inner PI controller regulating the armature current. Evaluates performance across different phase margins (30°, 60°, 85°).
* **`P2_Speed_Cascade_Controller` (Outer Loop):** Implementation of the slower outer speed PI controller that calculates the reference torque/current for the inner loop.
* **`P3_Angular_Position_Controller`:** Introduces a third, outermost control loop to regulate the specific angular position (θ) of the motor shaft.
* **`P4_Zero_Integral_Gain_Analysis`:** Analyzes steady-state error and system stability when the integral gain (ki) is set to zero (pure Proportional control) for both the current and speed loops.
