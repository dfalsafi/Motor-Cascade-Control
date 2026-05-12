# DC Motor Cascade Control System

## Overview
This repository contains the design, simulation, and analysis of a multi-loop cascade control system for a DC motor. This cascaded topology is widely used in modern motor drives and Field-Oriented Control (FOC) systems. The project was developed using **MATLAB** for control gain calculations and **Simulink** for system modeling and dynamic response simulation.

## System Dynamics & Plant Model
The DC motor model connects the electrical and mechanical systems together. The plant transfer functions act as low-pass filters due to the electrical properties (resistance and inductance) and mechanical properties (moment of inertia and viscous friction).

**1. Electrical System:**
The electrical dynamics are governed by the armature voltage equation:
$$V_a = E_a + L \frac{di}{dt} + iR$$
where $V_a$ is the armature terminal voltage, $i$ is the armature current, $R$ is the armature resistance, $L$ is the inductance, and $E_a$ is the back-electromotive force.

**2. Mechanical System:**
The mechanical dynamics are governed by Newton's second law for rotation:
$$\tau_{em} = \tau_l + J \frac{d\omega}{dt} + B\omega$$
where $\tau_{em}$ is the electromagnetic torque, $\tau_l$ is the applied load torque, $J$ is the moment of inertia, $B$ is the viscous friction coefficient, and $\omega$ is the rotor speed.

**3. Electromechanical Coupling:**
The electrical and mechanical domains are bridged using two equal coefficients: the torque constant ($k_t$) and the back-emf constant ($k_e$). In standard SI units, their values are equivalent ($k_e = k_t$). 

This equation relationship is visually displayed with the mechanical equation sitting directly on top of the electrical equation, traced for their connection with the constants in a block (represented as a triangle multiplier):
* The armature current (i) from the bottom electrical equation is traced up through a $k_t$ triangle multiplier block to produce the electromagnetic torque ($\tau_{em}$) in the top mechanical equation.
* The rotor speed ($\omega$) from the top mechanical equation is traced down through a $k_e$ triangle multiplier block to produce the back-emf ($E_a$) in the bottom electrical equation.

**Torque Equation:**
$$\tau_{em} = k_t i$$
*(where $i$ is the armature current)*

**Back-EMF Equation:**
$$E_a = k_e \omega$$
*(where $E_a$ is the induced electromotive force)*

**MATLAB and Simulink** were used to show this control design and implement the PI controller model, allowing for an accurate simulation of the system's combined electromechanical response.

## Control Architecture
The system utilizes a nested cascaded control topology, which allows for precise and stable control:
* **Inner Loop (Current Controller):** Regulates the motor's phase currents. Because the electrical dynamics are fast, this inner loop is designed to operate at a much **faster sampling rate** and higher bandwidth.
* **Outer Loop (Speed Controller):** Regulates the rotor's speed and operates at a **slower sampling rate**. This cascaded topology allows the outer speed controller to calculate a torque command, which it then passes as a reference to the inner current controller.

## DC Motor Parameters
The controllers were designed and simulated based on the following physical parameters of the DC motor:
* **Armature resistance ($R$):** $1 \, \Omega$
* **Armature inductance ($L$):** $4 \, mH$
* **Torque/Back-emf constant ($k_t = k_e$):** $0.1 \, Nm/A$ 
* **Rotational inertia ($J$):** $200\mu \, kg \cdot m^2$
* **Coefficient of viscous friction ($B$):** $500\mu \, kg \cdot m^2 \cdot s$

## Project Structure
* **`P1_Current_PI_Controller` (Inner Loop):** Design of the high-speed inner PI controller regulating the armature current. Evaluates performance across different phase margins (30°, 60°, 85°).
* **`P2_Speed_Cascade_Controller` (Outer Loop):** Implementation of the slower outer speed PI controller that calculates the reference torque/current for the inner loop.
* **`P3_Angular_Position_Controller`:** Introduces a third, outermost control loop to regulate the specific angular position ($\theta$) of the motor shaft.
* **`P4_Zero_Integral_Gain_Analysis`:** Analyzes steady-state error and system stability when the integral gain ($k_i$) is set to zero (pure Proportional control) for both the current and speed loops.
