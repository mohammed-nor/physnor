import 'package:flutter_test/flutter_test.dart';
import 'package:physnor/physnor.dart';

void main() {
  test('buildRequestPayload includes system prompt and user message', () {
    final specialist = PhysNOR(apiKey: 'dummy', model: 'exampleModel');
    final payload = specialist.buildRequestPayload(
      'What is Newton\'s second law?',
      0.1,
    );

    final messages = payload['prompt']['messages'] as List<dynamic>;
    expect(messages.length, 2);
    expect(messages[0]['author'], 'system');
    expect(messages[1]['author'], 'user');
    expect(
      (messages[1]['content'] as String).toLowerCase(),
      contains('newton'),
    );
  });

  group('scientific model library', () {
    test(
      'FickFirstLaw flux matches expected diffusive flux sign convention',
      () {
        final flux = FickFirstLaw.flux(
          diffusionCoefficient: 1e-9,
          concentrationGradient: 1000.0,
        );

        expect(flux, closeTo(-1e-6, 1e-12));
      },
    );

    test('LangmuirIsotherm calculates monolayer adsorption capacity', () {
      final qe = LangmuirIsotherm.qe(qmax: 500.0, kl: 0.25, ce: 20.0);

      expect(qe, closeTo(2500.0 / 6.0, 1e-9));
    });

    test(
      'ArrheniusModel computes the rate constant from activation energy',
      () {
        final k = ArrheniusModel.rateConstant(
          preExponentialFactor: 1.2e9,
          activationEnergyJmol: 50000.0,
          temperatureK: 298.15,
        );

        expect(k, greaterThan(0.0));
        expect(k, lessThan(1.2e9));
      },
    );

    test('GibbsFreeEnergy calculates delta G under standard conditions', () {
      final deltaG = GibbsFreeEnergy.deltaG(
        deltaH: -120000.0,
        deltaS: -250.0,
        temperatureK: 298.15,
      );

      expect(deltaG, closeTo(-120000.0 - (298.15 * -250.0), 1e-6));
    });

    test('FourierHeatConduction calculates steady heat flux', () {
      final flux = FourierHeatConduction.heatFlux(
        thermalConductivity: 0.8,
        temperatureGradient: 40.0,
      );

      expect(flux, closeTo(-32.0, 1e-9));
    });

    test('NernstEquation calculates electrode potential', () {
      final potential = NernstEquation.potential(
        standardPotentialV: 0.0,
        reactionQuotient: 10.0,
        electrons: 1,
        temperatureK: 298.15,
      );

      expect(potential, closeTo(-0.05916, 1e-3));
    });

    test('scientific models reject invalid inputs', () {
      expect(
        () => FickFirstLaw.flux(
          diffusionCoefficient: -1.0,
          concentrationGradient: 1.0,
        ),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => LangmuirIsotherm.qe(qmax: -10.0, kl: 1.0, ce: 1.0),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => ArrheniusModel.rateConstant(
          preExponentialFactor: 0.0,
          activationEnergyJmol: 1000.0,
          temperatureK: 300.0,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'remaining model families calculate physically meaningful results',
      () {
        final pressureRatio = ClausiusClapeyron.pressureRatio(
          enthalpyJmol: 40000.0,
          temperatureK: 300.0,
          temperatureDeltaK: 20.0,
        );

        final polymerViscosity = PolymerViscosity.viscosity(
          viscosityZero: 3.5,
          shearRate: 10.0,
          flowIndex: 0.8,
        );

        final laplace = YoungLaplace.pressureDifference(
          surfaceTension: 0.072,
          radius: 1e-3,
        );

        final blackbody = BlackbodyRadiation.spectralRadiance(
          wavelengthM: 1e-6,
          temperatureK: 3000.0,
        );

        final absorbance = LambertBeer.absorbance(
          molarAbsorptivity: 1200.0,
          pathLengthM: 0.01,
          concentrationM: 0.5,
        );

        final energy = ParticleInBox.energyLevel(
          quantumNumber: 2,
          boxLengthM: 1e-9,
          massKg: 9.1093837015e-31,
        );

        final population = BoltzmannDistribution.populationRatio(
          energyDifferenceJ: 1.0e-20,
          temperatureK: 300.0,
        );

        final pdf = GaussianDistribution.pdf(x: 0.0, mean: 0.0, sigma: 1.0);

        expect(pressureRatio, greaterThan(0.0));
        expect(polymerViscosity, greaterThan(0.0));
        expect(laplace, greaterThan(0.0));
        expect(blackbody, greaterThan(0.0));
        expect(absorbance, closeTo(6.0, 1e-9));
        expect(energy, greaterThan(0.0));
        expect(population, greaterThan(0.0));
        expect(pdf, closeTo(0.3989422804, 1e-7));
      },
    );
  });
}
