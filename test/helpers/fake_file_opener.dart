import 'package:photogallery/services/platform_service/file_opener_service/i_file_opener_service.dart';

class FakeFileOpenerService implements IFileOpenerService {
  FakeFileOpenerService({this.succeeds = true});

  bool succeeds;
  int callCount = 0;
  String? lastPath;

  @override
  Future<bool> open(String path) async {
    callCount++;
    lastPath = path;
    return succeeds;
  }
}
