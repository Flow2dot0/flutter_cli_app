import 'dart:io';

class GenerateDirectories{

  String basePath;
  final String blocsPath = '/blocs';
  final String uiScreenPath = '/ui/screens';

  String get blocsFullPath => basePath + blocsPath;
  String get uiScreenFullPath => basePath + uiScreenPath;

  GenerateDirectories(String basePath){
    /// Receive a [basePath] as argument
    /// Creating blocs dir
    /// Creating ui/screens dir
    this.basePath = basePath;
    createDir(blocsFullPath);
    createDir(uiScreenFullPath);
  }

  /// Checking if [path] is directory
  Future<bool> checkDir(String path) async => await FileSystemEntity.isDirectory(path);

  void createDir(String path) async{
    /// Creating directory
    var isDir = await checkDir(basePath);
    if(isDir){
      var result = await Directory(path).create(recursive: true);
      if(result!=null) {
        print("Success : all directories created...");
      }
    }
  }
}