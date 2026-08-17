import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Butler-Volmer equation for electrode kinetics.
///
/// \[
/// j = j_0 \left(e^{\alpha_a F \eta / RT} - e^{-\alpha_c F \eta / RT}\right)
/// \]
class ButlerVolmer {
  const ButlerVolmer._();

  /// Calculates current density from overpotential.
  static double currentDensity({
    required double exchangeCurrentDensity,
    required double alphaAnodic,
    required double alphaCathodic,
    required double overpotentialV,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'exchangeCurrentDensity',
      exchangeCurrentDensity,
    );
    ChemNORValidation.requirePositiveFinite('alphaAnodic', alphaAnodic);
    ChemNORValidation.requirePositiveFinite('alphaCathodic', alphaCathodic);
    ChemNORValidation.requireFinite('overpotentialV', overpotentialV);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    const r = 8.31446261815324;
    const f = 96485.33212;
    final anodic = alphaAnodic * f * overpotentialV / (r * temperatureK);
    final cathodic = alphaCathodic * f * overpotentialV / (r * temperatureK);
    return exchangeCurrentDensity * (math.exp(anodic) - math.exp(-cathodic));
  }
}
