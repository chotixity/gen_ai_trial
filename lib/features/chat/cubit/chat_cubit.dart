import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gen_ai_trial/features/chat/utils/chat.dart';
import 'package:gen_ai_trial/features/chat/models/message.dart';

part 'chat_state.dart';
part 'chat_cubit.freezed.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required Chat chat})
      : _chat = chat,
        super(const ChatState.initial());

  late final Chat _chat;
  List<Message> history = [];

  void sendMessage(Message message) async {
    emit(const ChatState.loading());

    try {
      final response = await _chat.sendMessage(message: message);
      history.addAll([message, Message(text: response.text!, fromUser: false)]);
      emit(ChatState.loaded(history: history));
    } catch (e) {
      emit(ChatState.error(e.toString()));
    }
  }
}
