# physnor

PhysNOR is a small Dart package that provides a physics-focused AI helper.
It wraps a Gemini-style generative model endpoint and guides the model with
an expert-level physics system prompt so answers are rigorous, derivations
are shown, and results include units and dimensional checks.

## Features

- Expert-focused system prompt for physics reasoning (theory + experiment).
- Simple `ask(...)` and `chatAsk(...)` APIs for single queries or chat flows.
- In-memory conversation helpers to integrate with chat UIs.

## Getting started

Add the package to your `pubspec.yaml` (replace with the published version):

```yaml
dependencies:
	physnor: ^0.0.1
```

This package requires you to provide a Gemini-style API key. The package does
not ship with any credentials — set your key from secure storage or an
environment variable and pass it to `PhysNOR`.

## Usage

Basic single-query example (see `example/bin/main.dart`):

```dart
import 'package:physnor/physnor.dart';

Future<void> main() async {
	final assistant = PhysNOR(apiKey: '<YOUR_GEMINI_API_KEY>');
	assistant.setModel('models/gemini');

	final answer = await assistant.ask('Explain the photoelectric effect with equations and units.');
	print(answer);
}
```

Chat-style usage:

```dart
final messages = [
	{'author': 'user', 'content': 'How does a mass-spring oscillator behave?'}
];
final reply = await assistant.chatAsk(messages);
print(reply);
```

## Example

See [example/bin/main.dart](example/bin/main.dart) for a runnable example. Run it using:

```bash
dart run example/bin/main.dart
```

(Note: ensure the `apiKey` is set in the example before running.)

## Publishing to pub.dev

1. Update `version:` in `pubspec.yaml`.
2. Validate with a dry run:

```bash
dart pub publish --dry-run
```

3. Publish:

```bash
dart pub publish
```

## License

This package is published under BSD 3-Clause LICENSE.

