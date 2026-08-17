import '../../utils/chemnor_validation.dart';

/// Einstein diffusion relation for random motion.
///
/// \[
/// \langle x^2 \rangle = 2 d D t
/// \]
class EinsteinDiffusion {
  const EinsteinDiffusion._();

  /// Calculates the mean square displacement in m^2.
  static double meanSquareDisplacement({
    required double diffusionCoefficient,
    required double time,
    required int dimensions,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    ChemNORValidation.requirePositiveFinite('time', time);
    if (dimensions <= 0) {
      throw ArgumentError.value(dimensions, 'dimensions', 'must be positive');
    }

    return 2 * dimensions * diffusionCoefficient * time;
  }
}
