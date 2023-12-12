# Team 8 Information Leakage 

This project explores information leakage in various encryption module implementations and demonstrates how certain encryption strategies can be vulnerable to information leakage, as well as how to secure them against such vulnerabilities.

## Prerequisites

- Visual Studio Code with HDL Language Support Extension.
- Icarus Verilog for simulation.
- GTKWave for waveform analysis.

## Installation

1. **Visual Studio Code HDL Extension:**
   - Install Visual Studio Code.
   - Within VS Code, install the HDL Language Support extension for Verilog syntax highlighting.

2. **Icarus Verilog:**
   - Download and install Icarus Verilog from the [official website](http://iverilog.icarus.com/) for compiling and running Verilog simulations.

3. **GTKWave:**
   - Download and install GTKWave from the [official website](http://gtkwave.sourceforge.net/) for viewing waveform outputs of simulations.

## Project Structure

The project is divided into four main directories, each corresponding to a different encryption module:

- `encryption1`: Basic encryption module that demonstrates direct information leakage.
- `encryption2`: Secure encryption module with XOR-based obfuscation.
- `encryption3`: Nonlinear encryption module showcasing nonlinearity as a means to prevent leakage.
- `encryption4`: Enhanced encryption module with complex operations to mitigate information leakage.

## Running Simulations

Navigate to the directory of the module you wish to simulate and run the following commands:
this is for the fourth module:
1. **Compile the Verilog Module:**
-` iverilog -o enhanced_encryption_test tb_enhanced_encryption_module.v enhanced_encryption_module.v`
2. **Execute the Simulation:**
- `vvp enhanced_encryption_test`
3. **Analyse Leakage:**
- `python3 enhanced_analyze_leakage.py`
3. **View Waveforms:**
- `gtkwave enhanced_waveform.vcd`

Repeat the above steps for `encryption1`, `encryption2`, `encryption3`, and `encryption4` directories.

## Analyzing Information Leakage

Each module directory contains a Python script to analyze potential information leakage. Run the following command to execute the analysis script:
-python analyze_leakage.py

Replace `analyze_leakage.py` with the respective script name for each module.

## Description of Encryption Modules

- `encryption1`: Demonstrates a basic encryption algorithm where bits are doubled or left unchanged based on the key, leading to potential information leakage.
- `encryption2`: Introduces a basic level of security by applying XOR to the encrypted bits, obscuring the direct relationship between the input and output.
- `encryption3`: Implements non-linear transformations to further prevent information leakage.
- `encryption4`: Combines multiple cryptographic principles to enhance security and mitigate information leakage effectively.

## Conclusion

By examining these modules, we can understand the importance of non-linear and unpredictable encryption operations in preventing information leakage and ensuring the security of cryptographic systems.



