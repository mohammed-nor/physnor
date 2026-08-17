import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// BET isotherm for multilayer adsorption.
///
/// \[
/// q_e = \frac{q_{max} C_{BET} C_e}{(C_s - C_e)(1 + (C_{BET} - 1)C_e/C_s)}
/// \]
class BETIsotherm {
  const BETIsotherm._();

  /// Calculates the equilibrium adsorption capacity from BET parameters.
  static double qe({
    required double qmax,
    required double cBet,
    required double ce,
    required double cs,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('cBet', cBet);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);
    ChemNORValidation.requirePositiveFinite('cs', cs);

    if (ce >= cs) {
      throw ArgumentError.value(
        ce,
        'ce',
        'must be lower than saturation concentration',
      );
    }

    final x = ce / cs;
    return (qmax * cBet * ce) / ((cs - ce) * (1 + (cBet - 1) * x));
  }
}
