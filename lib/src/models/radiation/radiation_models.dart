import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Blackbody spectral radiance from Planck's law.
class BlackbodyRadiation {
  const BlackbodyRadiation._();

  static double spectralRadiance({
    required double wavelengthM,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite('wavelengthM', wavelengthM);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    final h = PhysicalConstants.planck;
    final c = PhysicalConstants.speedOfLight;
    final kB = PhysicalConstants.boltzmann;
    final exponent = (h * c) / (wavelengthM * kB * temperatureK);
    return (2.0 * h * c * c) /
        (math.pow(wavelengthM, 5) * (math.exp(exponent) - 1.0));
  }
}
