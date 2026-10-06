import 'package:open_filex/open_filex.dart';

import 'i_file_opener_service.dart';

class FileOpenerService implements IFileOpenerService {
  @override
  Future<bool> open(String path) async {
    try {
      final result = await OpenFilex.open(path);
      return result.type == ResultType.done;
    } on Exception {
      rethrow;
    } catch (_) {
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
