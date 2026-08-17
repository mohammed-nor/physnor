import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Particle in a box energy levels.
class ParticleInBox {
  const ParticleInBox._();

  static double energyLevel({
    required int quantumNumber,
    required double boxLengthM,
    required double massKg,
  }) {
    ChemNORValidation.requirePositiveFinite('boxLengthM', boxLengthM);
    ChemNORValidation.requirePositiveFinite('massKg', massKg);
    if (quantumNumber <= 0) {
      throw ArgumentError.value(
        quantumNumber,
        'quantumNumber',
        'must be positive',
      );
    }
    final h = PhysicalConstants.planck;
    final n = quantumNumber.toDouble();
    return (h * h * n * n) / (8.0 * massKg * boxLengthM * boxLengthM);
  }
}

/// Harmonic oscillator energy level.
class HarmonicOscillator {
  const HarmonicOscillator._();

  static double energyLevel({
    required int vibrationalQuantumNumber,
    required double frequencyHz,
  }) {
    ChemNORValidation.requirePositiveFinite('frequencyHz', frequencyHz);
    if (vibrationalQuantumNumber < 0) {
      throw ArgumentError.value(
        vibrationalQuantumNumber,
        'vibrationalQuantumNumber',
        'must be non-negative',
      );
    }
    final h = PhysicalConstants.planck;
    return h * frequencyHz * vibrationalQuantumNumber.toDouble() +
        0.5 * h * frequencyHz;
  }
}
