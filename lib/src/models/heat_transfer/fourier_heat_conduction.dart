import '../../utils/chemnor_validation.dart';

/// Fourier's law for steady-state heat conduction.
///
/// \[
/// q = -k \nabla T
/// \]
class FourierHeatConduction {
  const FourierHeatConduction._();

  /// Calculates the heat flux in W/m^2 from thermal conductivity and temperature gradient.
  static double heatFlux({
    required double thermalConductivity,
    required double temperatureGradient,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'thermalConductivity',
      thermalConductivity,
    );
    if (temperatureGradient.isNaN || temperatureGradient.isInfinite) {
      throw ArgumentError.value(
        temperatureGradient,
        'temperatureGradient',
        'must be finite',
      );
    }

    return -thermalConductivity * temperatureGradient;
  }

  /// Calculates the heat transfer rate through a slab.
  static double heatRate({
    required double thermalConductivity,
    required double area,
    required double temperatureDifference,
    required double thickness,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'thermalConductivity',
      thermalConductivity,
    );
    ChemNORValidation.requirePositiveFinite('area', area);
    ChemNORValidation.requirePositiveFinite('thickness', thickness);
    if (temperatureDifference.isNaN || temperatureDifference.isInfinite) {
      throw ArgumentError.value(
        temperatureDifference,
        'temperatureDifference',
        'must be finite',
      );
    }

    return (thermalConductivity * area * temperatureDifference) / thickness;
  }
}
