import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:gen_ai_trial/features/file_picker/file_picker.dart';

part 'pick_files_cubit.freezed.dart';
part 'pick_files_state.dart';

class PickFilesCubit extends Cubit<PickFilesState> {
  PickFilesCubit({required FilePickerHelper filePickerHelper})
      : _filePickerHelper = filePickerHelper,
        super(const PickFilesState.initial());

  late final FilePickerHelper _filePickerHelper;
  Future<void> pickFiles() async {
    emit(const PickFilesState.loading());
    try {
      final pickedFiles = await _filePickerHelper.pickFiles();
      emit(PickFilesState.loaded(pickedFiles: pickedFiles!));
    } catch (e) {
      emit(PickFilesState.error(e.toString()));
    }
  }
}
