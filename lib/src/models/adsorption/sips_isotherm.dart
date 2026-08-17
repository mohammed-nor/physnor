import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Sips adsorption isotherm.
///
/// \[
/// q_e = \frac{q_{max}(K_s C_e)^{n_s}}{1 + (K_s C_e)^{n_s}}
/// \]
class SipsIsotherm {
  const SipsIsotherm._();

  /// Calculates adsorption capacity for heterogeneous sites.
  static double qe({
    required double qmax,
    required double ks,
    required double ce,
    required double ns,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('ks', ks);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);
    ChemNORValidation.requirePositiveFinite('ns', ns);

    if (ce == 0) {
      return 0.0;
    }

    final x = ks * ce;
    return (qmax * math.pow(x, ns)) / (1 + math.pow(x, ns));
  }
}
