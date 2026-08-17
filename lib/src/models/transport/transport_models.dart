import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Maxwell-Stefan diffusion model for multicomponent diffusion.
class MaxwellStefanDiffusion {
  const MaxwellStefanDiffusion._();

  static double flux({
    required double diffusionCoefficient,
    required double concentrationDifference,
    required double membraneThickness,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite(
      'membraneThickness',
      membraneThickness,
    );
    ChemNORValidation.requireFinite(
      'concentrationDifference',
      concentrationDifference,
    );

    return (diffusionCoefficient * concentrationDifference) / membraneThickness;
  }
}

/// Knudsen diffusion in pores.
class KnudsenDiffusion {
  const KnudsenDiffusion._();

  static double diffusionCoefficient({
    required double poreDiameterM,
    required double temperatureK,
    required double molecularWeightKgMol,
  }) {
    ChemNORValidation.requirePositiveFinite('poreDiameterM', poreDiameterM);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    ChemNORValidation.requirePositiveFinite(
      'molecularWeightKgMol',
      molecularWeightKgMol,
    );

    final gasConstant = PhysicalConstants.universalGasConstant;
    final effectiveM = molecularWeightKgMol / 1000.0;
    return (poreDiameterM / 3.0) *
        math.sqrt((8.0 * gasConstant * temperatureK) / (math.pi * effectiveM));
  }
}

/// Darken diffusion model for diffusion in concentrated solids.
class DarkenDiffusion {
  const DarkenDiffusion._();

  static double effectiveDiffusionCoefficient({
    required double intrinsicDiffusionCoefficient,
    required double thermodynamicFactor,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'intrinsicDiffusionCoefficient',
      intrinsicDiffusionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite(
      'thermodynamicFactor',
      thermodynamicFactor,
    );

    return intrinsicDiffusionCoefficient * thermodynamicFactor;
  }
}

/// Thermal diffusion (Soret effect) model for concentration transport under a temperature gradient.
class ThermalDiffusion {
  const ThermalDiffusion._();

  static double flux({
    required double diffusionCoefficient,
    required double soretCoefficient,
    required double concentration,
    required double temperatureGradient,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requireFinite('soretCoefficient', soretCoefficient);
    ChemNORValidation.requireNonNegativeFinite('concentration', concentration);
    ChemNORValidation.requireFinite('temperatureGradient', temperatureGradient);

    return -diffusionCoefficient *
        concentration *
        soretCoefficient *
        temperatureGradient;
  }
}

/// Soret effect, with concentration flux driven by a temperature gradient.
class SoretEffect {
  const SoretEffect._();

  static double soretCoefficient({
    required double flux,
    required double concentration,
    required double temperatureGradient,
  }) {
    ChemNORValidation.requireFinite('flux', flux);
    ChemNORValidation.requireNonNegativeFinite('concentration', concentration);
    ChemNORValidation.requireFinite('temperatureGradient', temperatureGradient);

    if (concentration == 0) {
      throw ArgumentError.value(
        concentration,
        'concentration',
        'must be non-zero for a Soret coefficient',
      );
    }

    return -(flux / (concentration * temperatureGradient));
  }
}

/// Dufour effect for heat flux driven by a concentration gradient.
class DufourEffect {
  const DufourEffect._();

  static double heatFlux({
    required double dufourCoefficient,
    required double concentrationGradient,
  }) {
    ChemNORValidation.requireFinite('dufourCoefficient', dufourCoefficient);
    ChemNORValidation.requireFinite(
      'concentrationGradient',
      concentrationGradient,
    );

    return -dufourCoefficient * concentrationGradient;
  }
}

/// Nernst-Planck equation for ion transport.
class NernstPlanck {
  const NernstPlanck._();

  static double flux({
    required double diffusionCoefficient,
    required double concentration,
    required double electricField,
    required double valence,
    required double temperatureK,
    required double concentrationGradient,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requireNonNegativeFinite('concentration', concentration);
    ChemNORValidation.requireFinite('electricField', electricField);
    ChemNORValidation.requireFinite(
      'concentrationGradient',
      concentrationGradient,
    );
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const gasConstant = PhysicalConstants.universalGasConstant;
    const faraday = PhysicalConstants.faraday;
    final migrationTerm =
        (valence * faraday * electricField) / (gasConstant * temperatureK);
    return -diffusionCoefficient * concentrationGradient -
        diffusionCoefficient * concentration * migrationTerm;
  }
}

/// Poisson-Nernst-Planck model for ionic transport coupled with electrostatics.
class PoissonNernstPlanck {
  const PoissonNernstPlanck._();

  static double chargeDensity({
    required double permittivity,
    required double secondDerivativePotential,
  }) {
    ChemNORValidation.requirePositiveFinite('permittivity', permittivity);
    ChemNORValidation.requireFinite(
      'secondDerivativePotential',
      secondDerivativePotential,
    );

    return -permittivity * secondDerivativePotential;
  }
}
