import '../../utils/chemnor_validation.dart';

/// Second-order kinetics for a bimolecular reaction.
///
/// \[
/// \frac{1}{C(t)} = \frac{1}{C_0} + k t
/// \]
class SecondOrderKinetics {
  const SecondOrderKinetics._();

  /// Calculates concentration at time `t` for a simple second-order decay.
  static double concentrationAtTime({
    required double initialConcentration,
    required double rateConstant,
    required double time,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'initialConcentration',
      initialConcentration,
    );
    ChemNORValidation.requirePositiveFinite('rateConstant', rateConstant);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return 1.0 / ((1.0 / initialConcentration) + (rateConstant * time));
  }
}
