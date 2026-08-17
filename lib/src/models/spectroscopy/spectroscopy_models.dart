import '../../utils/chemnor_validation.dart';

/// Beer-Lambert law for absorbance in spectroscopy.
class LambertBeer {
  const LambertBeer._();

  static double absorbance({
    required double molarAbsorptivity,
    required double pathLengthM,
    required double concentrationM,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'molarAbsorptivity',
      molarAbsorptivity,
    );
    ChemNORValidation.requirePositiveFinite('pathLengthM', pathLengthM);
    ChemNORValidation.requireNonNegativeFinite(
      'concentrationM',
      concentrationM,
    );

    return molarAbsorptivity * pathLengthM * concentrationM;
  }
}

/// Simple Raman shift relation from incoming and scattered wavelength.
class RamanShift {
  const RamanShift._();

  static double wavenumberShift({
    required double incidentWavelengthM,
    required double scatteredWavelengthM,
  }) {
    ChemNORValidation.requirePositiveFinite(
      'incidentWavelengthM',
      incidentWavelengthM,
    );
    ChemNORValidation.requirePositiveFinite(
      'scatteredWavelengthM',
      scatteredWavelengthM,
    );

    return (1.0 / incidentWavelengthM) - (1.0 / scatteredWavelengthM);
  }
}
