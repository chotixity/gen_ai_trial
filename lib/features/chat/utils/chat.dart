import 'dart:io';
import 'package:gen_ai_trial/features/chat/models/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

@Injectable()
class Chat {
  final String apiKey = const String.fromEnvironment('apiKey');
  late final GenerativeModel _model;
  late final ChatSession _chat;

  Chat() {
    _model = GenerativeModel(apiKey: apiKey, model: 'gemini-1.5-flash-latest');
    _chat = _model.startChat();
  }

  Future<GenerateContentResponse> sendMessage(
      {File? file, required Message message}) async {
    final response = await _chat.sendMessage(Content.text(message.text));
    print(response.text);
    // Return the response wrapped in GenerateContentResponse.
    return response;
  }
}
