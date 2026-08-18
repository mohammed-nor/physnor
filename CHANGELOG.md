## 1.0.2

Add scientific models for heat transfer, kinetics, phase change, polymer, quantum, radiation, spectroscopy, statistics, surface science, thermodynamics, and transport

- Implement Newton cooling law and Stefan-Boltzmann radiation law in heat_transfer_models.dart
- Add various adsorption kinetics models including Elovich, Intraparticle diffusion, Weber-Morris, Boyd, Film diffusion, and Bangham in adsorption_kinetics.dart
- Introduce Arrhenius model for temperature dependence of rate constants in arrhenius_model.dart
- Implement first-order and second-order kinetics models in first_order_kinetics.dart and second_order_kinetics.dart respectively
- Add pseudo-first-order and pseudo-second-order models in pseudo_first_order.dart and pseudo_second_order.dart
- Implement Clausius-Clapeyron relation and vapor pressure calculations in phase_change_models.dart
- Add polymer viscosity and Mark-Houwink relation models in polymer_models.dart
- Introduce particle in a box and harmonic oscillator energy levels in quantum_models.dart
- Implement blackbody radiation spectral radiance in radiation_models.dart
- Add Beer-Lambert law and Raman shift relation in spectroscopy_models.dart
- Implement Gaussian and Boltzmann distributions in statistics_models.dart
- Add Young-Laplace and Kelvin equations in surface_science_models.dart
- Implement Clapeyron equation and Gibbs free energy calculations in thermodynamics models
- Add van't Hoff relation for equilibrium constants in vanthoff_equation.dart
- Implement Einstein diffusion and Fick's laws in transport_models.dart
- Introduce Stokes-Einstein relation for diffusion coefficient in stokes_einstein.dart
- Add validation utilities in chemnor_validation.dart for input checks across models
- Update http dependency version to ^1.6.0