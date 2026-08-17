import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Navier-Stokes momentum equation in compact form.
class NavierStokes {
  const NavierStokes._();

  static double pressureGradientForce({
    required double density,
    required double viscosity,
    required double velocityGradient,
  }) {
    ChemNORValidation.requirePositiveFinite('density', density);
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);
    ChemNORValidation.requireFinite('velocityGradient', velocityGradient);

    return density * velocityGradient + viscosity * velocityGradient;
  }
}

/// Euler fluid model for inviscid flow.
class EulerFluidModel {
  const EulerFluidModel._();

  static double dynamicPressure({
    required double density,
    required double velocity,
  }) {
    ChemNORValidation.requirePositiveFinite('density', density);
    ChemNORValidation.requireNonNegativeFinite('velocity', velocity);

    return 0.5 * density * velocity * velocity;
  }
}

/// Hagen-Poiseuille equation for laminar flow in a circular tube.
class HagenPoiseuille {
  const HagenPoiseuille._();

  static double volumetricFlowRate({
    required double radius,
    required double pressureDrop,
    required double viscosity,
    required double length,
  }) {
    ChemNORValidation.requirePositiveFinite('radius', radius);
    ChemNORValidation.requireFinite('pressureDrop', pressureDrop);
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);
    ChemNORValidation.requirePositiveFinite('length', length);

    return (math.pi * math.pow(radius, 4) * pressureDrop) /
        (8.0 * viscosity * length);
  }
}

/// Darcy law for porous flow.
class DarcyLaw {
  const DarcyLaw._();

  static double flowRate({
    required double permeability,
    required double area,
    required double viscosity,
    required double pressureDrop,
    required double length,
  }) {
    ChemNORValidation.requirePositiveFinite('permeability', permeability);
    ChemNORValidation.requirePositiveFinite('area', area);
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);
    ChemNORValidation.requireFinite('pressureDrop', pressureDrop);
    ChemNORValidation.requirePositiveFinite('length', length);

    return (permeability * area * pressureDrop) / (viscosity * length);
  }
}

/// Forchheimer model for non-Darcy flow in porous media.
class ForchheimerModel {
  const ForchheimerModel._();

  static double pressureGradient({
    required double viscosity,
    required double permeability,
    required double density,
    required double velocity,
    required double inertialCoefficient,
  }) {
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);
    ChemNORValidation.requirePositiveFinite('permeability', permeability);
    ChemNORValidation.requirePositiveFinite('density', density);
    ChemNORValidation.requireNonNegativeFinite('velocity', velocity);
    ChemNORValidation.requireFinite('inertialCoefficient', inertialCoefficient);

    return (viscosity / permeability) * velocity +
        inertialCoefficient * density * velocity * velocity;
  }
}

/// Brinkman model for flow in porous media.
class BrinkmanModel {
  const BrinkmanModel._();

  static double effectiveViscosity({
    required double fluidViscosity,
    required double porosity,
  }) {
    ChemNORValidation.requirePositiveFinite('fluidViscosity', fluidViscosity);
    ChemNORValidation.requireProbability('porosity', porosity);

    return fluidViscosity / porosity;
  }
}

/// Stokes flow drag force.
class StokesFlow {
  const StokesFlow._();

  static double dragForce({
    required double viscosity,
    required double radius,
    required double velocity,
  }) {
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);
    ChemNORValidation.requirePositiveFinite('radius', radius);
    ChemNORValidation.requireNonNegativeFinite('velocity', velocity);

    return 6.0 * math.pi * viscosity * radius * velocity;
  }
}

/// Reynolds number for flow regime estimation.
class ReynoldsNumber {
  const ReynoldsNumber._();

  static double reynoldsNumber({
    required double density,
    required double velocity,
    required double diameter,
    required double viscosity,
  }) {
    ChemNORValidation.requirePositiveFinite('density', density);
    ChemNORValidation.requireNonNegativeFinite('velocity', velocity);
    ChemNORValidation.requirePositiveFinite('diameter', diameter);
    ChemNORValidation.requirePositiveFinite('viscosity', viscosity);

    return (density * velocity * diameter) / viscosity;
  }
}

/// Bingham plastic fluid model.
class BinghamPlastic {
  const BinghamPlastic._();

  static double shearStress({
    required double yieldStress,
    required double plasticViscosity,
    required double shearRate,
  }) {
    ChemNORValidation.requireNonNegativeFinite('yieldStress', yieldStress);
    ChemNORValidation.requirePositiveFinite(
      'plasticViscosity',
      plasticViscosity,
    );
    ChemNORValidation.requireNonNegativeFinite('shearRate', shearRate);

    return yieldStress + plasticViscosity * shearRate;
  }
}

/// Herschel-Bulkley fluid model.
class HerschelBulkley {
  const HerschelBulkley._();

  static double shearStress({
    required double yieldStress,
    required double consistency,
    required double shearRate,
    required double flowIndex,
  }) {
    ChemNORValidation.requireNonNegativeFinite('yieldStress', yieldStress);
    ChemNORValidation.requirePositiveFinite('consistency', consistency);
    ChemNORValidation.requireNonNegativeFinite('shearRate', shearRate);
    ChemNORValidation.requirePositiveFinite('flowIndex', flowIndex);

    return yieldStress + consistency * math.pow(shearRate, flowIndex);
  }
}

/// Power-law fluid model.
class PowerLawFluid {
  const PowerLawFluid._();

  static double shearStress({
    required double consistency,
    required double shearRate,
    required double flowIndex,
  }) {
    ChemNORValidation.requirePositiveFinite('consistency', consistency);
    ChemNORValidation.requireNonNegativeFinite('shearRate', shearRate);
    ChemNORValidation.requirePositiveFinite('flowIndex', flowIndex);

    return consistency * math.pow(shearRate, flowIndex);
  }
}
