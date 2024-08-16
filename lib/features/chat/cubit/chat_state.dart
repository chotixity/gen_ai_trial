part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.loaded({
    required List<Message> history,
  }) = _Loaded;
  const factory ChatState.error(String message) = _Error;
}
