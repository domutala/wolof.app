import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<File?> select({FileType type = FileType.any}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);
  if (result != null) {
    File file = File(result.files.single.path!);
    return file;
  }

  return null;
}
