import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Newton cooling law.
class NewtonCooling {
  const NewtonCooling._();

  static double temperatureAtTime({
    required double ambientTemperatureK,
    required double initialTemperatureK,
    required double heatTransferCoefficient,
    required double time,
    required double area,
    required double mass,
    required double specificHeat,
  }) {
    ChemNORValidation.requireTemperatureK(
      'ambientTemperatureK',
      ambientTemperatureK,
    );
    ChemNORValidation.requireTemperatureK(
      'initialTemperatureK',
      initialTemperatureK,
    );
    ChemNORValidation.requirePositiveFinite(
      'heatTransferCoefficient',
      heatTransferCoefficient,
    );
    ChemNORValidation.requireNonNegativeFinite('time', time);
    ChemNORValidation.requirePositiveFinite('area', area);
    ChemNORValidation.requirePositiveFinite('mass', mass);
    ChemNORValidation.requirePositiveFinite('specificHeat', specificHeat);

    final tau = (mass * specificHeat) / (heatTransferCoefficient * area);
    return ambientTemperatureK +
        (initialTemperatureK - ambientTemperatureK) * math.exp(-time / tau);
  }
}

/// Stefan-Boltzmann radiation law.
class StefanBoltzmannRadiation {
  const StefanBoltzmannRadiation._();

  static double heatFlux({
    required double emissivity,
    required double temperatureK,
    required double ambientTemperatureK,
  }) {
    ChemNORValidation.requireProbability('emissivity', emissivity);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    ChemNORValidation.requireTemperatureK(
      'ambientTemperatureK',
      ambientTemperatureK,
    );

    return emissivity *
        PhysicalConstants.stefanBoltzmann *
        (math.pow(temperatureK, 4) - math.pow(ambientTemperatureK, 4));
  }
}

/// Planck radiation law.
class PlanckRadiation {
  const PlanckRadiation._();

  static double spectralRadiance({
    required double wavelengthM,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite('wavelengthM', wavelengthM);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    final c = PhysicalConstants.speedOfLight;
    final h = PhysicalConstants.planck;
    final kB = PhysicalConstants.boltzmann;
    final exponent = (h * c) / (wavelengthM * kB * temperatureK);
    return (2.0 * h * c * c) /
        (math.pow(wavelengthM, 5) * (math.exp(exponent) - 1.0));
  }
}

/// Wien displacement law.
class WienDisplacement {
  const WienDisplacement._();

  static double peakWavelengthM({required double temperatureK}) {
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    return 2.897771955e-3 / temperatureK;
  }
}

/// Kirchhoff radiation law.
class KirchhoffRadiation {
  const KirchhoffRadiation._();

  static double emissivityFromAbsorptivity({required double absorptivity}) {
    ChemNORValidation.requireProbability('absorptivity', absorptivity);

    return absorptivity;
  }
}

/// Lumped capacitance model.
class LumpedCapacitance {
  const LumpedCapacitance._();

  static double temperatureAtTime({
    required double initialTemperatureK,
    required double ambientTemperatureK,
    required double convectionCoefficient,
    required double area,
    required double mass,
    required double specificHeat,
    required double time,
  }) {
    final tau = (mass * specificHeat) / (convectionCoefficient * area);
    return ambientTemperatureK +
        (initialTemperatureK - ambientTemperatureK) * math.exp(-time / tau);
  }
}

/// Biot number for transient conduction.
class BiotNumber {
  const BiotNumber._();

  static double biotNumber({
    required double convectionCoefficient,
    required double characteristicLength,
    required double thermalConductivity,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'convectionCoefficient',
      convectionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite(
      'characteristicLength',
      characteristicLength,
    );
    ChemNORValidation.requirePositiveFinite(
      'thermalConductivity',
      thermalConductivity,
    );

    return (convectionCoefficient * characteristicLength) / thermalConductivity;
  }
}

/// Thermal diffusivity.
class ThermalDiffusivity {
  const ThermalDiffusivity._();

  static double alpha({
    required double thermalConductivity,
    required double density,
    required double specificHeat,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'thermalConductivity',
      thermalConductivity,
    );
    ChemNORValidation.requirePositiveFinite('density', density);
    ChemNORValidation.requirePositiveFinite('specificHeat', specificHeat);

    return thermalConductivity / (density * specificHeat);
  }
}
