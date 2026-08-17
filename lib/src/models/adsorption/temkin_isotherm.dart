import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Temkin adsorption isotherm.
///
/// \[
/// q_e = \frac{RT}{b} \ln(K_T C_e)
/// \]
class TemkinIsotherm {
  const TemkinIsotherm._();

  /// Calculates adsorption capacity using a Temkin form.
  static double qe({
    required double b,
    required double kt,
    required double ce,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite('b', b);
    ChemNORValidation.requirePositiveFinite('kt', kt);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    if (ce == 0) {
      return 0.0;
    }

    final constant = (8.31446261815324 * temperatureK) / b;
    return constant * math.log(kt * ce);
  }
}
