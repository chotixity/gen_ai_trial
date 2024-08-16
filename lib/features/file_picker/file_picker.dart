import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class FilePickerHelper {
  Future<FilePickerResult?> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['jpg', 'jpg'],
        type: FileType.custom,
      );
      return result;
    } catch (e) {
      throw Exception('could not pick Files: $e');
    }
  }
}
