import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Fick's first law for steady-state diffusion.
///
/// The model implements the flux relation
/// \[
/// J = -D \nabla C
/// \]
/// where `D` is the diffusion coefficient in m^2/s and `grad(C)` is the
/// concentration gradient in mol/m^4 (or equivalent concentration per length).
class FickFirstLaw {
  const FickFirstLaw._();

  /// Calculates diffusive flux from a diffusion coefficient and concentration gradient.
  ///
  /// The sign convention follows Fick's law: flux is opposite to the
  /// concentration gradient. A positive gradient gives a negative flux.
  static double flux({
    required double diffusionCoefficient,
    required double concentrationGradient,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    if (concentrationGradient.isNaN || concentrationGradient.isInfinite) {
      throw ArgumentError.value(
        concentrationGradient,
        'concentrationGradient',
        'must be finite',
      );
    }

    return -diffusionCoefficient * concentrationGradient;
  }

  /// Calculates the diffusion coefficient from flux and gradient.
  static double diffusionCoefficient({
    required double flux,
    required double concentrationGradient,
  }) {
    ChemNORValidation.requireNonNegativeFinite('flux', flux.abs());
    ChemNORValidation.requireNonZero(
      'concentrationGradient',
      concentrationGradient,
    );
    return -(flux / concentrationGradient);
  }
}

/// Fick's second law for time-dependent diffusion.
class FickSecondLaw {
  const FickSecondLaw._();

  /// One-dimensional diffusion equation on a homogeneous medium.
  ///
  /// \[
  /// \frac{\partial C}{\partial t} = D \frac{\partial^2 C}{\partial x^2}
  /// \]
  static double concentrationChange({
    required double diffusionCoefficient,
    required double secondDerivativeOfConcentration,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'diffusionCoefficient',
      diffusionCoefficient,
    );
    if (secondDerivativeOfConcentration.isNaN ||
        secondDerivativeOfConcentration.isInfinite) {
      throw ArgumentError.value(
        secondDerivativeOfConcentration,
        'secondDerivativeOfConcentration',
        'must be finite',
      );
    }

    return diffusionCoefficient * secondDerivativeOfConcentration;
  }
}
