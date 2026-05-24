import 'package:physnor/physnor.dart';

Future<void> main() async {
  // Replace with your real Gemini API key. Consider loading from
  // secure storage or environment variables in production.
  final assistant = PhysNOR(apiKey: '<YOUR_GEMINI_API_KEY>');
  assistant.setModel('models/gemini');

  final question = 'Explain the photoelectric effect with equations and units.';
  try {
    final answer = await assistant.ask(question);
    print('Assistant answer:\n');
    print(answer);
  } catch (e) {
    print('Request failed: $e');
  }
}
