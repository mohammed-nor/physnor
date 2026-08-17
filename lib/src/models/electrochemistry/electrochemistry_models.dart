import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Tafel equation for high overpotential electrochemical kinetics.
class TafelEquation {
  const TafelEquation._();

  static double overpotential({
    required double exchangeCurrentDensity,
    required double currentDensity,
    required double tafelSlope,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'exchangeCurrentDensity',
      exchangeCurrentDensity,
    );
    ChemNORValidation.requireNonNegativeFinite(
      'currentDensity',
      currentDensity,
    );
    ChemNORValidation.requirePositiveFinite('tafelSlope', tafelSlope);

    if (currentDensity == 0) return 0.0;
    return tafelSlope * math.log(currentDensity / exchangeCurrentDensity);
  }
}

/// Gouy-Chapman model for diffuse double layer structure.
class GouyChapman {
  const GouyChapman._();

  static double surfacePotential({
    required double zetaPotential,
    required double inverseDebyeLength,
    required double distance,
  }) {
    ChemNORValidation.requireFinite('zetaPotential', zetaPotential);
    ChemNORValidation.requireNonNegativeFinite(
      'inverseDebyeLength',
      inverseDebyeLength,
    );
    ChemNORValidation.requireNonNegativeFinite('distance', distance);

    return zetaPotential * math.exp(-inverseDebyeLength * distance);
  }
}

/// Stern model for interfacial electrochemistry.
class SternModel {
  const SternModel._();

  static double totalCharge({
    required double compactLayerCapacitance,
    required double diffuseLayerCapacitance,
    required double potentialDifference,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'compactLayerCapacitance',
      compactLayerCapacitance,
    );
    ChemNORValidation.requirePositiveFinite(
      'diffuseLayerCapacitance',
      diffuseLayerCapacitance,
    );
    ChemNORValidation.requireFinite('potentialDifference', potentialDifference);

    return (compactLayerCapacitance *
            diffuseLayerCapacitance *
            potentialDifference) /
        (compactLayerCapacitance + diffuseLayerCapacitance);
  }
}

/// Helmholtz model for compact double-layer capacitance.
class HelmholtzModel {
  const HelmholtzModel._();

  static double capacitance({
    required double dielectricConstant,
    required double area,
    required double separation,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'dielectricConstant',
      dielectricConstant,
    );
    ChemNORValidation.requirePositiveFinite('area', area);
    ChemNORValidation.requirePositiveFinite('separation', separation);

    return (PhysicalConstants.vacuumPermittivity * dielectricConstant * area) /
        separation;
  }
}

/// Randles-Sevcik equation for peak current in voltammetry.
class RandlesSevcik {
  const RandlesSevcik._();

  static double peakCurrent({
    required double diffusionCoefficient,
    required double concentration,
    required double scanRate,
    required double area,
    required double electrons,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite('concentration', concentration);
    ChemNORValidation.requirePositiveFinite('scanRate', scanRate);
    ChemNORValidation.requirePositiveFinite('area', area);
    ChemNORValidation.requirePositiveFinite('electrons', electrons.toDouble());
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const gasConstant = PhysicalConstants.universalGasConstant;
    return 0.4463 *
        area *
        concentration *
        math.sqrt(
          diffusionCoefficient *
              scanRate *
              electrons *
              gasConstant *
              temperatureK,
        );
  }
}

/// Cottrell equation for chronoamperometry.
class CottrellEquation {
  const CottrellEquation._();

  static double currentDensity({
    required double concentration,
    required double diffusionCoefficient,
    required double time,
    required double electrons,
  }) {
    ChemNORValidation.requirePositiveFinite('concentration', concentration);
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite('time', time);
    ChemNORValidation.requirePositiveFinite('electrons', electrons.toDouble());

    return (electrons *
        PhysicalConstants.faraday *
        concentration *
        math.sqrt(diffusionCoefficient / (math.pi * time)));
  }
}

/// Debye-Hückel limiting law for ionic activity coefficients.
class DebyeHuckel {
  const DebyeHuckel._();

  static double activityCoefficient({
    required double ionicStrength,
    required double ionChargeSquared,
  }) {
    ChemNORValidation.requireNonNegativeFinite('ionicStrength', ionicStrength);
    ChemNORValidation.requirePositiveFinite(
      'ionChargeSquared',
      ionChargeSquared,
    );

    return 1.0 - 0.509 * math.sqrt(ionicStrength) * ionChargeSquared;
  }
}

/// Onsager transport relation.
class OnsagerTransport {
  const OnsagerTransport._();

  static double flux({required double mobility, required double drivingForce}) {
    ChemNORValidation.requirePositiveFinite('mobility', mobility);
    ChemNORValidation.requireFinite('drivingForce', drivingForce);

    return mobility * drivingForce;
  }
}
