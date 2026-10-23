# GA-Based PID Controller Tuning for a Nonlinear Coupled-Tank System

## About the Project

This is our academic project in which we are using a Genetic Algorithm (GA) to find better PID controller parameters for a nonlinear coupled-tank system.

We created the system model in MATLAB/Simulink and used a Genetic Algorithm to optimize the PID controller gains (Kp, Ki, Kd). We then compared the performance of the conventional PID controller with the GA-tuned PID controller.

## Objectives

- To understand the working of a nonlinear coupled-tank system.
- To model the system using MATLAB/Simulink.
- To implement a PID controller for liquid-level control.
- To use a Genetic Algorithm to tune the PID gains.
- To compare both controllers using simulation results.

## Software Used

- MATLAB
- Simulink
- MATLAB Global Optimization Toolbox

## How We Did It

1. Created a nonlinear coupled-tank model in Simulink.
2. Added a PID controller to control the liquid level.
3. Created a fitness function using Integral of Squared Error (ISE).
4. Used a Genetic Algorithm to find suitable PID parameters.
5. Compared the responses of the conventional and GA-tuned PID controllers.

## Results

We compared the controllers based on the following parameters:

- Integral of Squared Error (ISE)
- Overshoot
- Settling time
- Steady-state error
- Maximum tank level

The simulation results showed that the GA-tuned PID controller performed better than our initial conventional PID controller for the tested model.

## Project Files

- MATLAB/ – MATLAB code and Simulink model
- Results/ – Simulation graphs and comparison results
- Report/ – Project report (will be added later)

## Future Improvements

- Test different Genetic Algorithm settings.
- Compare GA with other optimization methods.
- Test the controller under different operating conditions.
- Explore the project on a real coupled-tank setup.

## Team Members

1. Mansuri Mohammedshaqlein Mahmudhusain
2. Ansari Junedahmed
3. Ansari Nizamuddin Vahajuddin

## College

L. D. College of Engineering, Ahmedabad  
Instrumentation and Control Engineering

*Academic project developed for studying intelligent PID controller tuning.*
