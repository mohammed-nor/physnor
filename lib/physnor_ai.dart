import 'dart:convert';

import 'package:http/http.dart' as http;

/// A small adapter that talks to a Gemini-style generative model and
/// presents a `PhysNOR` helper to fetch physics answers.
class PhysNOR {
  final String apiKey;
  String model;
  final String systemPrompt;

  /// Optional in-memory conversation useful for chat apps. Each message is a
  /// map with keys: 'author' and 'content'. Use `addUserMessage` /
  /// `addAssistantMessage` to manage it.
  final List<Map<String, String>> conversation = [];

  PhysNOR({required this.apiKey, String? model, String? systemPrompt})
    : model = model ?? 'models/gemini',
      systemPrompt = systemPrompt ?? _defaultUltimatePrompt;

  /// Change the target model (e.g. 'models/gemini' or 'myOrg/myModel').
  void setModel(String newModel) {
    model = newModel;
  }

  static const String _defaultUltimatePrompt =
      '''You are a world class theoretical and experimental physicist with deep expertise in classical mechanics, electromagnetism, thermodynamics, statistical mechanics, quantum mechanics, relativity, condensed matter, optics, fluid dynamics, plasma physics, particle physics, astrophysics, and computational physics.

Your role is to help me solve physics problems, explain concepts, derive equations, design experiments, check assumptions, and think like a real scientist.

Core behavior:

Think rigorously and logically.
Use first principles before shortcuts.
Explain clearly.
Start simple, then move to advanced detail.
Show all derivations step by step.
Do not skip algebra, units, or reasoning.
Always define symbols and variables.
Use SI units unless I request otherwise.
Check dimensional consistency in every equation.
State assumptions explicitly.
When solving problems:
Identify knowns and unknowns
Choose governing laws
Derive solution
Compute final result
Interpret physical meaning
Mention limits or edge cases
When explaining concepts:
Use intuition
Use analogies
Use math
Give real world examples
When uncertainty exists:
Say what is certain
Say what is estimated
Compare alternatives
If I make an error, correct me directly and explain why.
If the topic is advanced, teach at graduate level.
If I say “ELI5”, explain for a beginner.
If coding is useful, use Python, MATLAB, Mathematica, or pseudocode.
If data is involved:
Fit models
Estimate errors
Plot trends
Interpret results
Think like a researcher:
Challenge assumptions
Suggest better models
Mention approximations
Compare theory vs experiment

Response format:

A. Summary
B. Physics principles used
C. Step by step solution
D. Final answer
E. Physical interpretation
F. Common mistakes
G. Next deeper question to explore
''';

  /// Build the JSON payload sent to the AI endpoint.
  Map<String, dynamic> buildRequestPayload(
    String question,
    double temperature,
  ) {
    return {
      'prompt': {
        'messages': [
          {'author': 'system', 'content': systemPrompt},
          {'author': 'user', 'content': question},
        ],
      },
      'temperature': temperature,
      'maxOutputTokens': 800,
    };
  }

  /// Ask the physics specialist a question and return the raw text response.
  ///
  /// Send a single-question request to the configured model and return text.
  /// The `model` field is used to build the request URI for the provider.
  Future<String> ask(String question, {double temperature = 0.2}) async {
    final payload = buildRequestPayload(question, temperature);
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/${model}:generateText',
    );
    final resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(payload),
    );

    if (resp.statusCode != 200) {
      throw Exception('Request failed: ${resp.statusCode} ${resp.body}');
    }

    return _extractText(resp.body);
  }

  /// Add a user message to the in-memory conversation.
  void addUserMessage(String content) {
    conversation.add({'author': 'user', 'content': content});
  }

  /// Add an assistant message to the in-memory conversation.
  void addAssistantMessage(String content) {
    conversation.add({'author': 'assistant', 'content': content});
  }

  /// Clear the in-memory conversation.
  void clearConversation() {
    conversation.clear();
  }

  /// Build a chat-style payload from a list of messages (maps with
  /// 'author'/'content'). Ensures the system prompt is the first message.
  Map<String, dynamic> buildChatPayload(
    List<Map<String, String>> messages,
    double temperature,
  ) {
    final msgs = <Map<String, String>>[];
    // Ensure system prompt present as first message
    if (messages.isEmpty || messages.first['author'] != 'system') {
      msgs.add({'author': 'system', 'content': systemPrompt});
    }
    msgs.addAll(messages);

    return {
      'prompt': {'messages': msgs},
      'temperature': temperature,
      'maxOutputTokens': 800,
    };
  }

  /// Send a chat-style list of messages to the model and return the text.
  Future<String> chatAsk(
    List<Map<String, String>> messages, {
    double temperature = 0.2,
  }) async {
    final payload = buildChatPayload(messages, temperature);
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/${model}:generateText',
    );
    final resp = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(payload),
    );

    if (resp.statusCode != 200) {
      throw Exception('Request failed: ${resp.statusCode} ${resp.body}');
    }

    return _extractText(resp.body);
  }

  String _extractText(String body) {
    try {
      final jsonBody = jsonDecode(body);
      if (jsonBody is Map<String, dynamic>) {
        // Try common Gemini-style shapes
        final candidates = jsonBody['candidates'];
        if (candidates is List && candidates.isNotEmpty) {
          final first = candidates.first as Map<String, dynamic>;
          final content = first['content'];
          if (content is List) {
            final texts = content
                .map((c) => c['text'] ?? c['content'])
                .whereType<String>();
            if (texts.isNotEmpty) return texts.join('\n');
          }
          if (first['text'] is String) return first['text'] as String;
        }

        if (jsonBody['output'] is Map && jsonBody['output']['text'] is String) {
          return jsonBody['output']['text'] as String;
        }
        if (jsonBody['text'] is String) return jsonBody['text'] as String;
      }
    } catch (_) {}
    return body;
  }
}
