import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Arrhenius model for temperature dependence of a rate constant.
///
/// \[
/// k = A \exp\left(-\frac{E_a}{R T}\right)
/// \]
class ArrheniusModel {
  const ArrheniusModel._();

  /// Calculates the rate constant `k` in s^-1 or appropriate units depending on the
  /// reaction order.
  static double rateConstant({
    required double preExponentialFactor,
    required double activationEnergyJmol,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'preExponentialFactor',
      preExponentialFactor,
    );
    ChemNORValidation.requirePositiveFinite(
      'activationEnergyJmol',
      activationEnergyJmol,
    );
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const r = 8.31446261815324;
    final exponent = -(activationEnergyJmol / (r * temperatureK));
    return preExponentialFactor * ChemNORValidation.safeExp(exponent);
  }

  /// Calculates activation energy from a known rate constant and temperature.
  static double activationEnergy({
    required double rateConstant,
    required double preExponentialFactor,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite('rateConstant', rateConstant);
    ChemNORValidation.requirePositiveFinite(
      'preExponentialFactor',
      preExponentialFactor,
    );
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const r = 8.31446261815324;
    final ratio = rateConstant / preExponentialFactor;
    if (ratio <= 0) {
      throw ArgumentError.value(
        rateConstant,
        'rateConstant',
        'must be positive for Arrhenius analysis',
      );
    }
    return -r * temperatureK * math.log(ratio);
  }
}
