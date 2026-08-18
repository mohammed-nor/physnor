# physnor

PhysNOR is a Dart package that combines a physics-focused AI assistant with a scientific model library for chemistry and engineering calculations. It supports both conversational reasoning with `PhysNOR` and direct numerical modeling through static scientific classes.

## Features

- Physics-focused AI helper for prompt-driven analysis and derivations.
- Static model API for scientific equations and engineering correlations.
- Validation helpers for positive, finite, and thermodynamic inputs.
- Coverage across transport, adsorption, kinetics, thermodynamics, heat transfer, fluids, electrochemistry, and advanced domains.

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  physnor: ^1.0.2
```

Then import the library:

```dart
import 'package:physnor/physnor.dart';
```

## AI assistant usage

Basic single-query example:

```dart
import 'package:physnor/physnor.dart';

Future<void> main() async {
  final assistant = PhysNOR(apiKey: '<YOUR_GEMINI_API_KEY>');
  assistant.setModel('models/gemini');

  final answer = await assistant.ask(
    'Explain the photoelectric effect with equations and units.',
  );

  print(answer);
}
```

Chat-style usage:

```dart
final messages = [
  {'author': 'user', 'content': 'How does a mass-spring oscillator behave?'},
];

final reply = await assistant.chatAsk(messages);
print(reply);
```

See [example/bin/main.dart](example/bin/main.dart) for a runnable example.

## Scientific model library

The numerical model layer is organized by scientific domain. All models are exposed through the package root, and the API follows a consistent static-call pattern:

```dart
final flux = FickFirstLaw.flux(
  diffusionCoefficient: 1e-9,
  concentrationGradient: 1000.0,
);

final qe = LangmuirIsotherm.qe(
  qmax: 500.0,
  kl: 0.25,
  ce: 20.0,
);
```

### 1. Transport

Models:

- `FickFirstLaw`, `FickSecondLaw`
- `EinsteinDiffusion`
- `StokesEinstein`
- `MaxwellStefanDiffusion`
- `KnudsenDiffusion`
- `DarkenDiffusion`
- `ThermalDiffusion`
- `SoretEffect`
- `DufourEffect`
- `NernstPlanck`
- `PoissonNernstPlanck`

Usage:

```dart
final diffusiveFlux = FickFirstLaw.flux(
  diffusionCoefficient: 1e-9,
  concentrationGradient: 1000.0,
);

final ds = EinsteinDiffusion.msd(
  diffusionCoefficient: 1e-9,
  time: 10.0,
  dimensions: 3,
);

final msf = MaxwellStefanDiffusion.flux(
  diffusionCoefficient: 2.5e-10,
  concentrationDifference: 0.5,
  membraneThickness: 1e-4,
);
```

### 2. Adsorption

Models:

- `LangmuirIsotherm`
- `FreundlichIsotherm`
- `TemkinIsotherm`
- `BETIsotherm`
- `SipsIsotherm`
- `DubininRadushkevichIsotherm`
- `DubininAstakhovIsotherm`
- `RedlichPetersonIsotherm`
- `TothIsotherm`
- `HalseyIsotherm`
- `ElovichAdsorption`
- `FowlerGuggenheimModel`

Usage:

```dart
final qe = LangmuirIsotherm.qe(
  qmax: 500.0,
  kl: 0.25,
  ce: 20.0,
);

final freundlich = FreundlichIsotherm.qe(
  kf: 15.0,
  n: 1.8,
  ce: 10.0,
);

final bet = BETIsotherm.qe(
  qmax: 200.0,
  k1: 0.5,
  k2: 0.02,
  ce: 5.0,
);
```

### 3. Kinetics

Models:

- `ArrheniusModel`
- `FirstOrderKinetics`
- `SecondOrderKinetics`
- `PseudoFirstOrder`
- `PseudoSecondOrder`
- `ElovichKinetics`
- `IntraparticleDiffusion`
- `WeberMorrisModel`
- `BoydModel`
- `FilmDiffusion`
- `BanghamModel`

Usage:

```dart
final k = ArrheniusModel.rateConstant(
  preExponentialFactor: 1.2e9,
  activationEnergyJmol: 50000.0,
  temperatureK: 298.15,
);

final c = FirstOrderKinetics.concentration(
  initialConcentration: 10.0,
  rateConstant: 0.12,
  time: 5.0,
);

final qt = ElovichKinetics.qt(
  alpha: 2.0,
  beta: 0.5,
  time: 12.0,
);
```

### 4. Thermodynamics

Models:

- `GibbsFreeEnergy`
- `VanthoffEquation`
- `ClapeyronEquation`
- `ClausiusClapeyron`

Usage:

```dart
final deltaG = GibbsFreeEnergy.deltaG(
  deltaH: -120000.0,
  deltaS: -250.0,
  temperatureK: 298.15,
);

final k = GibbsFreeEnergy.equilibriumConstant(
  deltaGStandard: -5000.0,
  temperatureK: 298.15,
);

final pressureRatio = ClausiusClapeyron.pressureRatio(
  enthalpyJmol: 40000.0,
  temperatureK: 300.0,
  temperatureDeltaK: 20.0,
);
```

### 5. Heat transfer

Models:

- `FourierHeatConduction`
- `NewtonCooling`
- `StefanBoltzmannRadiation`
- `PlanckRadiation`
- `WienDisplacement`
- `KirchhoffRadiation`
- `LumpedCapacitance`
- `BiotNumber`
- `ThermalDiffusivity`

Usage:

```dart
final heatFlux = FourierHeatConduction.heatFlux(
  thermalConductivity: 0.8,
  temperatureGradient: 40.0,
);

final tempAtTime = NewtonCooling.temperatureAtTime(
  ambientTemperatureK: 293.15,
  initialTemperatureK: 350.0,
  heatTransferCoefficient: 15.0,
  time: 60.0,
  area: 0.5,
  mass: 2.0,
  specificHeat: 4200.0,
);
```

### 6. Fluid dynamics

Models:

- `BernoulliEquation`
- `NavierStokes`
- `EulerFluidModel`
- `HagenPoiseuille`
- `DarcyLaw`
- `ForchheimerModel`
- `BrinkmanModel`
- `StokesFlow`
- `ReynoldsNumber`
- `BinghamPlastic`
- `HerschelBulkley`
- `PowerLawFluid`

Usage:

```dart
final flow = HagenPoiseuille.volumetricFlowRate(
  radius: 0.01,
  pressureDrop: 1500.0,
  viscosity: 0.001,
  length: 2.0,
);

final re = ReynoldsNumber.reynoldsNumber(
  density: 1000.0,
  velocity: 0.5,
  diameter: 0.02,
  viscosity: 0.001,
);
```

### 7. Electrochemistry

Models:

- `NernstEquation`
- `ButlerVolmer`
- `TafelEquation`
- `GouyChapman`
- `SternModel`
- `HelmholtzModel`
- `RandlesSevcik`
- `CottrellEquation`
- `DebyeHuckel`
- `OnsagerTransport`

Usage:

```dart
final potential = NernstEquation.potential(
  standardPotentialV: 0.0,
  reactionQuotient: 10.0,
  electrons: 1,
  temperatureK: 298.15,
);

final current = ButlerVolmer.currentDensity(
  exchangeCurrentDensity: 1e-4,
  overpotential: 0.1,
  symmetryFactor: 0.5,
  electrons: 1,
);
```

### 8. Phase change, polymers, surface science, quantum, radiation, spectroscopy, statistics, and environmental models

Models:

- Phase change: `ClausiusClapeyron`
- Polymers: `PolymerViscosity`, `MarkHouwink`
- Surface science: `YoungLaplace`, `KelvinEquation`
- Quantum: `ParticleInBox`, `HarmonicOscillator`
- Radiation: `BlackbodyRadiation`
- Spectroscopy: `LambertBeer`, `RamanShift`
- Statistics: `GaussianDistribution`, `BoltzmannDistribution`
- Environmental: `FirstOrderDecay`, `EnvironmentalAdsorption`

Usage:

```dart
final ratio = ClausiusClapeyron.pressureRatio(
  enthalpyJmol: 40000.0,
  temperatureK: 300.0,
  temperatureDeltaK: 20.0,
);

final drift = YoungLaplace.pressureDifference(
  surfaceTension: 0.072,
  radius: 1e-3,
);

final absorbance = LambertBeer.absorbance(
  molarAbsorptivity: 1200.0,
  pathLengthM: 0.01,
  concentrationM: 0.5,
);

final pdf = GaussianDistribution.pdf(
  x: 0.0,
  mean: 0.0,
  sigma: 1.0,
);
```

## Example: full workflow

```dart
import 'package:physnor/physnor.dart';

void main() {
  final flux = FickFirstLaw.flux(
    diffusionCoefficient: 1e-9,
    concentrationGradient: 1000.0,
  );

  final qe = LangmuirIsotherm.qe(
    qmax: 500.0,
    kl: 0.25,
    ce: 20.0,
  );

  final arrhenius = ArrheniusModel.rateConstant(
    preExponentialFactor: 1.2e9,
    activationEnergyJmol: 50000.0,
    temperatureK: 298.15,
  );

  final nernst = NernstEquation.potential(
    standardPotentialV: 0.0,
    reactionQuotient: 10.0,
    electrons: 1,
    temperatureK: 298.15,
  );

  print('Fick flux = $flux');
  print('Langmuir qe = $qe');
  print('Arrhenius k = $arrhenius');
  print('Nernst potential = $nernst');
}
```

## License

This package is published under the BSD 3-Clause license.

