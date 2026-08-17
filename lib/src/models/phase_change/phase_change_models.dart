import 'dart:math' as math;

import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Clausius-Clapeyron relation for vapor pressure variation with temperature.
class ClausiusClapeyron {
  const ClausiusClapeyron._();

  static double pressureRatio({
    required double enthalpyJmol,
    required double temperatureK,
    required double temperatureDeltaK,
  }) {
    ChemNORValidation.requirePositiveFinite('enthalpyJmol', enthalpyJmol);
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    ChemNORValidation.requireNonNegativeFinite(
      'temperatureDeltaK',
      temperatureDeltaK,
    );

    final r = PhysicalConstants.universalGasConstant;
    final t1 = temperatureK;
    final t2 = temperatureK + temperatureDeltaK;
    final exponent = -(enthalpyJmol / r) * ((1 / t2) - (1 / t1));
    return math.exp(exponent);
  }

  static double vaporPressure({
    required double referencePressure,
    required double enthalpyJmol,
    required double referenceTemperatureK,
    required double temperatureK,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'referencePressure',
      referencePressure,
    );
    ChemNORValidation.requirePositiveFinite('enthalpyJmol', enthalpyJmol);
    ChemNORValidation.requireTemperatureK(
      'referenceTemperatureK',
      referenceTemperatureK,
    );
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);

    final r = PhysicalConstants.universalGasConstant;
    final exponent =
        -(enthalpyJmol / r) *
        ((1 / temperatureK) - (1 / referenceTemperatureK));
    return referencePressure * math.exp(exponent);
  }
}
