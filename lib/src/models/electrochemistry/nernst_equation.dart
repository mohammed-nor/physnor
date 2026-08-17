import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Nernst equation for electrode potentials.
///
/// \[
/// E = E^\circ - \frac{RT}{nF} \ln Q
/// \]
class NernstEquation {
  const NernstEquation._();

  /// Calculates the electrode potential in volts.
  static double potential({
    required double standardPotentialV,
    required double reactionQuotient,
    required int electrons,
    required double temperatureK,
  }) {
    ChemNORValidation.requireFinite('standardPotentialV', standardPotentialV);
    ChemNORValidation.requirePositiveFinite(
      'reactionQuotient',
      reactionQuotient,
    );
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    if (electrons <= 0) {
      throw ArgumentError.value(electrons, 'electrons', 'must be positive');
    }

    const gasConstant = PhysicalConstants.universalGasConstant;
    final factor =
        (gasConstant * temperatureK) / (electrons * PhysicalConstants.faraday);
    return standardPotentialV - factor * math.log(reactionQuotient);
  }
}
