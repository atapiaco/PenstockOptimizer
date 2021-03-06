![Loyola Logo](https://github.com/atapiaco/PenstockOptimizer/blob/master/files/logo.png)

# Integer programming to optimize Micro-Hydro Power Plants for generic river profiles
---
This files correspond to the implementation of the algorithm presented in the paper "Integer programming to optimize penstock layout for generic river profiles", submitted to [Renewable Energy](https://www.journals.elsevier.com/renewable-energy).

This paper addresses the problem of determining the optimal dam and turbine location for a non-linear river profile,
when micro-hydro schemes are studied. The aim of this analysis is to develop a linear integer problem that ensures the
resources involved are used in the most efficient manner. This is geared towards the application of micro-hydro plants
to supply marginal isolated areas, where both technology and resources are limited. For this purpose, a micro-hydro
plant model is first developed. Subsequently a discretization of the river profile is made, on the basis of which a
set of integer variables are proposed, being the model transformed then into an optimization problem. Finally, as an
application of the method, a penstock design is made for a river profile.

---

## How it works

The algorithm can be executed from *gui_penstock_optimizer.m*.

1. Using the button *IMPORT PROFILE*, the program reads a N-discretized river profile from an excel file, where column 1 and 2 are, respectively, the x and y coordinates of the N points of the discretization. After the importation, the river profile is plotted.

   * An example river profile, called *river_example.xlsx*, is given.
   
2. The problem data is introduced in the boxes.

   * Example values are preloaded.
   
3. Using the button *SOLVE* executes the solver. The linear system is built using the algorithm described in the paper, and a *branch and bound* routine is used to find the optimal solution, which is written in the *solution* box.

4. An *excel file* report can be easily generated with the button *GENERATE REPORT*. This report is compound of 2 sheets. The first one consists on a resume with the main output values. The second sheet includes the complete solution of the problem, listing all the nodes of the penstock.


