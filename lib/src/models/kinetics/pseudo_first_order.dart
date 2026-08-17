import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Pseudo-first-order kinetic model.
///
/// \[
/// q_t = q_e \left(1 - e^{-k_1 t}\right)
/// \]
class PseudoFirstOrder {
  const PseudoFirstOrder._();

  /// Calculates adsorbed amount at time `t`.
  static double qt({
    required double qe,
    required double k1,
    required double time,
  }) {
    ChemNORValidation.requireNonNegativeFinite('qe', qe);
    ChemNORValidation.requirePositiveFinite('k1', k1);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return qe * (1.0 - math.exp(-k1 * time));
  }
}
