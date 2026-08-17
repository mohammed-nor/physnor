import '../../utils/chemnor_validation.dart';

/// Bernoulli equation for incompressible, steady flow.
///
/// \[
/// p + \rho g h + \frac{1}{2}\rho v^2 = \text{constant}
/// \]
class BernoulliEquation {
  const BernoulliEquation._();

  /// Calculates the total pressure head term.
  static double totalHead({
    required double pressurePa,
    required double densityKgM3,
    required double heightM,
    required double velocityMPerS,
    required double gravityMPerS2,
  }) {
    ChemNORValidation.requirePositiveFinite('pressurePa', pressurePa);
    ChemNORValidation.requirePositiveFinite('densityKgM3', densityKgM3);
    ChemNORValidation.requireNonNegativeFinite('heightM', heightM);
    ChemNORValidation.requireNonNegativeFinite('velocityMPerS', velocityMPerS);
    ChemNORValidation.requirePositiveFinite('gravityMPerS2', gravityMPerS2);

    return pressurePa +
        densityKgM3 * gravityMPerS2 * heightM +
        0.5 * densityKgM3 * velocityMPerS * velocityMPerS;
  }
}
