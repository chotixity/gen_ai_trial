part of 'pick_files_cubit.dart';

@freezed
class PickFilesState with _$PickFilesState {
  const factory PickFilesState.initial() = _Initial;
  const factory PickFilesState.loading() = _Loading;
  const factory PickFilesState.loaded({
    required FilePickerResult pickedFiles,
  }) = _Loaded;
  const factory PickFilesState.error(String message) = _Error;
}
