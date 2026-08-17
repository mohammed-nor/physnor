import '../../utils/chemnor_validation.dart';

/// Thermodynamic model for Gibbs free energy.
///
/// \[
/// \Delta G = \Delta H - T \Delta S
/// \]
class GibbsFreeEnergy {
  const GibbsFreeEnergy._();

  /// Calculates the Gibbs free energy change in J/mol.
  static double deltaG({
    required double deltaH,
    required double deltaS,
    required double temperatureK,
  }) {
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    if (deltaH.isNaN ||
        deltaH.isInfinite ||
        deltaS.isNaN ||
        deltaS.isInfinite) {
      throw ArgumentError.value(deltaH, 'deltaH', 'must be finite');
    }

    return deltaH - temperatureK * deltaS;
  }

  /// Calculates the equilibrium constant for a reaction from ΔG°.
  static double equilibriumConstant({
    required double deltaGStandard,
    required double temperatureK,
  }) {
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    const r = 8.31446261815324;
    return ChemNORValidation.safeExp((-deltaGStandard) / (r * temperatureK));
  }
}
