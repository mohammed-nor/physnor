import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Polymer rheology model using a power-law viscosity relation.
class PolymerViscosity {
  const PolymerViscosity._();

  static double viscosity({
    required double viscosityZero,
    required double shearRate,
    required double flowIndex,
  }) {
    ChemNORValidation.requirePositiveFinite('viscosityZero', viscosityZero);
    ChemNORValidation.requireNonNegativeFinite('shearRate', shearRate);
    ChemNORValidation.requirePositiveFinite('flowIndex', flowIndex);

    if (shearRate == 0) return viscosityZero;
    return viscosityZero * math.pow(shearRate, flowIndex - 1.0);
  }
}

/// Mark-Houwink relation for polymer molecular weight and intrinsic viscosity.
class MarkHouwink {
  const MarkHouwink._();

  static double intrinsicViscosity({
    required double kValue,
    required double molecularWeight,
    required double exponent,
  }) {
    ChemNORValidation.requirePositiveFinite('kValue', kValue);
    ChemNORValidation.requirePositiveFinite('molecularWeight', molecularWeight);
    ChemNORValidation.requireFinite('exponent', exponent);

    return kValue * math.pow(molecularWeight, exponent);
  }
}
