import 'dart:math' as math;

import '../../utils/chemnor_validation.dart';

/// Elovich kinetic model.
class ElovichKinetics {
  const ElovichKinetics._();

  static double qt({
    required double alpha,
    required double beta,
    required double time,
  }) {
    ChemNORValidation.requirePositiveFinite('alpha', alpha);
    ChemNORValidation.requirePositiveFinite('beta', beta);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return (1.0 / beta) * math.log(1.0 + alpha * beta * time);
  }
}

/// Intraparticle diffusion model.
class IntraparticleDiffusion {
  const IntraparticleDiffusion._();

  static double qt({
    required double kId,
    required double time,
    required double c,
  }) {
    ChemNORValidation.requirePositiveFinite('kId', kId);
    ChemNORValidation.requireNonNegativeFinite('time', time);
    ChemNORValidation.requireFinite('c', c);

    return kId * math.sqrt(time) + c;
  }
}

/// Weber-Morris model.
class WeberMorrisModel {
  const WeberMorrisModel._();

  static double qt({
    required double kWM,
    required double time,
    required double c,
  }) {
    ChemNORValidation.requirePositiveFinite('kWM', kWM);
    ChemNORValidation.requireNonNegativeFinite('time', time);
    ChemNORValidation.requireFinite('c', c);

    return kWM * math.sqrt(time) + c;
  }
}

/// Boyd model for diffusion mechanism analysis.
class BoydModel {
  const BoydModel._();

  static double bt({
    required double fractionAdsorbed,
    required double equilibriumCapacity,
  }) {
    ChemNORValidation.requireNonNegativeFinite(
      'fractionAdsorbed',
      fractionAdsorbed,
    );
    ChemNORValidation.requirePositiveFinite(
      'equilibriumCapacity',
      equilibriumCapacity,
    );

    if (fractionAdsorbed > 1) {
      throw ArgumentError.value(
        fractionAdsorbed,
        'fractionAdsorbed',
        'must be between 0 and 1',
      );
    }

    return -math.log(1.0 - fractionAdsorbed);
  }
}

/// Film diffusion model.
class FilmDiffusion {
  const FilmDiffusion._();

  static double qt({
    required double equilibriumCapacity,
    required double kf,
    required double time,
  }) {
    ChemNORValidation.requireNonNegativeFinite(
      'equilibriumCapacity',
      equilibriumCapacity,
    );
    ChemNORValidation.requirePositiveFinite('kf', kf);
    ChemNORValidation.requireNonNegativeFinite('time', time);

    return equilibriumCapacity * (1.0 - math.exp(-kf * time));
  }
}

/// Bangham model.
class BanghamModel {
  const BanghamModel._();

  static double qt({
    required double equilibriumCapacity,
    required double kB,
    required double time,
    required double exponent,
  }) {
    ChemNORValidation.requireNonNegativeFinite(
      'equilibriumCapacity',
      equilibriumCapacity,
    );
    ChemNORValidation.requirePositiveFinite('kB', kB);
    ChemNORValidation.requireNonNegativeFinite('time', time);
    ChemNORValidation.requirePositiveFinite('exponent', exponent);

    return equilibriumCapacity *
        (1.0 - math.exp(-kB * math.pow(time, exponent)));
  }
}
