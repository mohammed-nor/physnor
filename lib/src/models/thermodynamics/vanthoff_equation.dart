import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// van't Hoff relation for equilibrium constants.
///
/// \[
/// \ln K = -\frac{\Delta H}{RT} + \frac{\Delta S}{R}
/// \]
class VanthoffEquation {
  const VanthoffEquation._();

  /// Calculates the equilibrium constant from thermodynamic parameters.
  static double equilibriumConstant({
    required double deltaH,
    required double deltaS,
    required double temperatureK,
  }) {
    ChemNORValidation.requireFinite('deltaH', deltaH);
    ChemNORValidation.requireFinite('deltaS', deltaS);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    final exponent =
        (-deltaH / (PhysicalConstants.universalGasConstant * temperatureK)) +
        (deltaS / PhysicalConstants.universalGasConstant);
    return math.exp(exponent);
  }
}
