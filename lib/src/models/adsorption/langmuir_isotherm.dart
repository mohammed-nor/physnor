import '../../utils/chemnor_validation.dart';

/// Langmuir adsorption isotherm for monolayer adsorption.
///
/// The model implements:
/// \[
/// q_e = \frac{q_{max} K_L C_e}{1 + K_L C_e}
/// \]
class LangmuirIsotherm {
  const LangmuirIsotherm._();

  /// Calculates adsorption capacity `qe` in mass adsorbate per mass adsorbent.
  static double qe({
    required double qmax,
    required double kl,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('kl', kl);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    return (qmax * kl * ce) / (1 + kl * ce);
  }

  /// Solves the equilibrium concentration from a known capacity.
  static double ce({
    required double qmax,
    required double kl,
    required double qe,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('kl', kl);
    ChemNORValidation.requireNonNegativeFinite('qe', qe);

    if (qe > qmax) {
      throw ArgumentError.value(
        qe,
        'qe',
        'must not exceed qmax for Langmuir adsorption',
      );
    }

    return (qe / (qmax - qe)) / kl;
  }
}
