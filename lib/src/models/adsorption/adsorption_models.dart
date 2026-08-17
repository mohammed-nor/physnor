import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Dubinin-Radushkevich isotherm for microporous adsorption.
class DubininRadushkevichIsotherm {
  const DubininRadushkevichIsotherm._();

  static double qe({
    required double qmax,
    required double adsorbentConstant,
    required double polanyiPotential,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite(
      'adsorbentConstant',
      adsorbentConstant,
    );
    ChemNORValidation.requireNonNegativeFinite(
      'polanyiPotential',
      polanyiPotential,
    );

    return qmax *
        math.exp(-adsorbentConstant * polanyiPotential * polanyiPotential);
  }
}

/// Dubinin-Astakhov isotherm for heterogeneous microporous adsorption.
class DubininAstakhovIsotherm {
  const DubininAstakhovIsotherm._();

  static double qe({
    required double qmax,
    required double daConstant,
    required double n,
    required double polanyiPotential,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('daConstant', daConstant);
    ChemNORValidation.requirePositiveFinite('n', n);
    ChemNORValidation.requireNonNegativeFinite(
      'polanyiPotential',
      polanyiPotential,
    );

    return qmax * math.exp(-daConstant * math.pow(polanyiPotential, n));
  }
}

/// Redlich-Peterson adsorption isotherm.
class RedlichPetersonIsotherm {
  const RedlichPetersonIsotherm._();

  static double qe({
    required double k,
    required double a,
    required double beta,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('k', k);
    ChemNORValidation.requirePositiveFinite('a', a);
    ChemNORValidation.requirePositiveFinite('beta', beta);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    if (ce == 0) return 0.0;
    return (k * a * ce) / (1 + a * math.pow(ce, beta));
  }
}

/// Toth adsorption isotherm.
class TothIsotherm {
  const TothIsotherm._();

  static double qe({
    required double qmax,
    required double k,
    required double n,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('k', k);
    ChemNORValidation.requirePositiveFinite('n', n);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    if (ce == 0) return 0.0;
    final denominator = math.pow((1.0 / k) + math.pow(ce, n), 1.0 / n);
    return qmax * ce / denominator;
  }
}

/// Halsey isotherm for multilayer adsorption.
class HalseyIsotherm {
  const HalseyIsotherm._();

  static double qe({
    required double qmax,
    required double halseyConstant,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('qmax', qmax);
    ChemNORValidation.requirePositiveFinite('halseyConstant', halseyConstant);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    if (ce == 0) return 0.0;
    return qmax * math.exp(-halseyConstant / ce);
  }
}

/// Elovich adsorption model.
class ElovichAdsorption {
  const ElovichAdsorption._();

  static double qe({
    required double alpha,
    required double beta,
    required double ce,
  }) {
    ChemNORValidation.requirePositiveFinite('alpha', alpha);
    ChemNORValidation.requirePositiveFinite('beta', beta);
    ChemNORValidation.requireNonNegativeFinite('ce', ce);

    return (1.0 / beta) * math.log(1.0 + alpha * beta * ce);
  }
}

/// Fowler-Guggenheim model accounting for lateral interactions.
class FowlerGuggenheimModel {
  const FowlerGuggenheimModel._();

  static double surfaceCoverage({
    required double interactionParameter,
    required double equilibriumConstant,
    required double concentration,
  }) {
    ChemNORValidation.requireFinite(
      'interactionParameter',
      interactionParameter,
    );
    ChemNORValidation.requirePositiveFinite(
      'equilibriumConstant',
      equilibriumConstant,
    );
    ChemNORValidation.requireNonNegativeFinite('concentration', concentration);

    final theta = equilibriumConstant * concentration;
    return theta / (1.0 + theta + interactionParameter * theta * theta);
  }
}
