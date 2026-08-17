import '../../constants/physical_constants.dart';
import '../../utils/chemnor_validation.dart';

/// Stokes-Einstein diffusion relation.
///
/// \[
/// D = \frac{k_B T}{6 \pi \eta r}
/// \]
class StokesEinstein {
  const StokesEinstein._();

  /// Calculates diffusion coefficient in m^2/s.
  static double diffusionCoefficient({
    required double temperatureK,
    required double viscosityPaS,
    required double radiusM,
  }) {
    ChemNORValidation.requireTemperatureK('temperatureK', temperatureK);
    ChemNORValidation.requirePositiveFinite('viscosityPaS', viscosityPaS);
    ChemNORValidation.requirePositiveFinite('radiusM', radiusM);

    return (PhysicalConstants.boltzmann * temperatureK) /
        (6.0 * PhysicalConstants.pi * viscosityPaS * radiusM);
  }
}
