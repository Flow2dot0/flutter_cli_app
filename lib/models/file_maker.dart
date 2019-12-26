import 'dart:io';

class FileMaker{

  void createDartFileAndWrite(String model, String filepath, String filename) async{
    /// get model updated [getModel]
    /// create file [dartFile]
    /// write [getModel]
    var getModel = model;
    var dartFile = await File('$filepath/$filename.dart');
    print(getModel);
    print(dartFile);
    if(dartFile!=null){
      dartFile.writeAsStringSync(model);
    }else{
      print("Error during compiling files...");
    }
  }
}