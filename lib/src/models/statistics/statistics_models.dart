import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Gaussian distribution PDF.
class GaussianDistribution {
  const GaussianDistribution._();

  static double pdf({
    required double x,
    required double mean,
    required double sigma,
  }) {
    ChemNORValidation.requireFinite('x', x);
    ChemNORValidation.requireFinite('mean', mean);
    ChemNORValidation.requirePositiveFinite('sigma', sigma);

    final exponent = -((x - mean) * (x - mean)) / (2.0 * sigma * sigma);
    return (1.0 / (sigma * math.sqrt(2.0 * math.pi))) * math.exp(exponent);
  }
}

/// Boltzmann distribution ratio for two states.
class BoltzmannDistribution {
  const BoltzmannDistribution._();

  static double populationRatio({
    required double energyDifferenceJ,
    required double temperatureK,
  }) {
    ChemNORValidation.requireFinite('energyDifferenceJ', energyDifferenceJ);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    return math.exp(
      -(energyDifferenceJ) /
          (PhysicalConstants.universalGasConstant * temperatureK),
    );
  }
}
