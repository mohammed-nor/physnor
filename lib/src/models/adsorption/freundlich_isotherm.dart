import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Freundlich adsorption isotherm.
///
/// \[
/// q_e = K_F C_e^{1/n}
/// \]
class FreundlichIsotherm {
  const FreundlichIsotherm._();

  /// Calculates equilibrium adsorption capacity `qe`.
  static double qe({
    required double kf,
    required double n,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('kf', kf);
    ChemNORValidation.requirePositiveFinite('n', n);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    if (ce == 0) {
      return 0.0;
    }

    return kf * math.pow(ce, 1.0 / n);
  }
}
