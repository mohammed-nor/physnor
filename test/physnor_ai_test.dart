import 'package:flutter_test/flutter_test.dart';
import 'package:physnor/physnor_ai.dart';

void main() {
  test('buildRequestPayload includes system prompt and user message', () {
    final specialist = PhysicsSpecialist(
      apiKey: 'dummy',
      model: 'exampleModel',
    );
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
}
