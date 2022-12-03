# R8-MBE-multiplier-with-Dadda-Tree
The R8 - Modified Booth Encoder based multiplier with Dadda Tree is a project developed for the "Integrated Systems Architecture" course @ Politecnico di Torino.
The goal of this project is to develop in SystemVerilog a radix 8 Booth multiplier to be used as the mantissa multiplier of a Floating Point Unit.
The adder plane relies on a Dadda-like tree, where compression is achieved by using (when possible) 5/3 compressors.
The multiplier has been simulated first as a stand-alone component and then included in the FPU for benchmarking.
