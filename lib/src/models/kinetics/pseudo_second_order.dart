import '../../utils/chemnor_validation.dart';

/// Pseudo-second-order kinetic model.
///
/// \[
/// q_t = \frac{k_2 q_e^2 t}{1 + k_2 q_e t}
/// \]
class PseudoSecondOrder {
  const PseudoSecondOrder._();

  /// Calculates the adsorbed amount at time `t`.
  static double qt({
    required double qe,
    required double k2,
    required double time,
  }) {
    ChemNORValidation.requireNonNegativeFinite('qe', qe);
    ChemNORValidation.requirePositiveFinite('k2', k2);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return (k2 * qe * qe * time) / (1 + k2 * qe * time);
  }
}
