import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Young-Laplace relation for pressure difference across a curved interface.
class YoungLaplace {
  const YoungLaplace._();

  static double pressureDifference({
    required double surfaceTension,
    required double radius,
  }) {
    ChemNORValidation.requirePositiveFinite('surfaceTension', surfaceTension);
    ChemNORValidation.requirePositiveFinite('radius', radius);

    return 2.0 * surfaceTension / radius;
  }
}

/// Kelvin equation for vapor pressure over a curved surface.
class KelvinEquation {
  const KelvinEquation._();

  static double relativePressure({
    required double surfaceTension,
    required double molarVolume,
    required double radius,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite('surfaceTension', surfaceTension);
    ChemNORValidation.requirePositiveFinite('molarVolume', molarVolume);
    ChemNORValidation.requirePositiveFinite('radius', radius);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const r = PhysicalConstants.universalGasConstant;
    return math.exp(
      (2.0 * surfaceTension * molarVolume) / (r * temperatureK * radius),
    );
  }
}
