import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Clapeyron equation for phase equilibrium.
///
/// \[
/// \ln\left(\frac{P_2}{P_1}\right) = -\frac{\Delta H_{vap}}{R}\left(\frac{1}{T_2}-\frac{1}{T_1}\right)
/// \]
class ClapeyronEquation {
  const ClapeyronEquation._();

  /// Calculates the pressure at a second temperature from the first temperature.
  static double pressureAtTemperature({
    required double deltaHvapJmol,
    required double pressure1Pa,
    required double temperature1K,
    required double temperature2K,
  }) {
    ChemNORValidation.requirePositiveFinite('deltaHvapJmol', deltaHvapJmol);
    ChemNORValidation.requirePositiveFinite('pressure1Pa', pressure1Pa);
    ChemNORValidation.requireTemperatureK('temperature1K', temperature1K);
    ChemNORValidation.requireTemperatureK('temperature2K', temperature2K);

    final exponent =
        (-deltaHvapJmol /
            (PhysicalConstants.universalGasConstant * temperature1K)) +
        (deltaHvapJmol /
            (PhysicalConstants.universalGasConstant * temperature2K));

    return pressure1Pa * math.exp(exponent);
  }
}
