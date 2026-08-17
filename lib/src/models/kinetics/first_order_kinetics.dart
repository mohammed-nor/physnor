import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// First-order kinetics for concentration decay.
///
/// \[
/// C(t) = C_0 e^{-kt}
/// \]
class FirstOrderKinetics {
  const FirstOrderKinetics._();

  /// Calculates concentration at time `t`.
  static double concentrationAtTime({
    required double initialConcentration,
    required double rateConstant,
    required double time,
  }) {
    ChemNORValidation.requireNonNegativeFinite(
      'initialConcentration',
      initialConcentration,
    );
    ChemNORValidation.requirePositiveFinite('rateConstant', rateConstant);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return initialConcentration * math.exp(-rateConstant * time);
  }

  /// Calculates half-life for first-order decay.
  static double halfLife({required double rateConstant}) {
    ChemNORValidation.requirePositiveFinite('rateConstant', rateConstant);
    return math.log(2.0) / rateConstant;
  }
}
