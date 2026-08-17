import '../../utils/chemnor_validation.dart';

/// First-order decay for environmental contaminant removal.
class FirstOrderDecay {
  const FirstOrderDecay._();

  static double concentration({
    required double initialConcentration,
    required double decayConstantPerTime,
    required double time,
  }) {
    ChemNORValidation.requireNonNegativeFinite(
      'initialConcentration',
      initialConcentration,
    );
    ChemNORValidation.requirePositiveFinite(
      'decayConstantPerTime',
      decayConstantPerTime,
    );
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return initialConcentration * (1.0 / (1.0 + decayConstantPerTime * time));
  }
}

/// Simple environmental adsorption-removal model.
class EnvironmentalAdsorption {
  const EnvironmentalAdsorption._();

  static double removalEfficiency({
    required double equilibriumConstant,
    required double pollutantConcentration,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'equilibriumConstant',
      equilibriumConstant,
    );
    ChemNORValidation.requireNonNegativeFinite(
      'pollutantConcentration',
      pollutantConcentration,
    );

    return (equilibriumConstant * pollutantConcentration) /
        (1.0 + equilibriumConstant * pollutantConcentration);
  }
}
