import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async{

  /// Parse [arguments] from terminal
  /// Create commands
  var cliParser = CliParser(arguments)
    ..createCommand();
  /// Read [arguments] and get a map
  Map<String, dynamic> params = cliParser.readArgs()?? {};

  if(params.isNotEmpty){

    /// Removing old file
    /// Create new file
    /// Add [params['DESTINATION_FOLDER_PATH']]
    /// Add [params['JSON_PATH']]
    /// Close sink
    await File('${Directory.current.path}/lib/config/save_paths.yaml').delete(recursive: true);
    var yamlData = await File('${Directory.current.path}/lib/config/save_paths.yaml');
    var sink = yamlData.openWrite(mode: FileMode.append);
    sink.write("DESTINATION_FOLDER_PATH: '${params['DESTINATION_FOLDER_PATH']}'\n");
    sink.write("JSON_PATH: '${params['JSON_PATH']}'");
    await sink.flush();
    await sink.close();

    /// Generate the folder structure
    GenDirs(params['DESTINATION_FOLDER_PATH']);

    /// wait until the project is setting up
    /// depends on your actual computer speed
    await Future.delayed((Duration(seconds: 2)));

    /// Read the json file
    /// loop on [jsonList]
    /// generate _bloc files
    /// generate _screen files
    String jsonData = await File(params['JSON_PATH']).readAsStringSync();
    List jsonList = jsonDecode(jsonData);
    for(Map map in jsonList){
      FileMaker().createDartFileAndWrite(
          Bloc().toCompleteStarterBloc(map['title'], map['type']),
          params['DESTINATION_FOLDER_PATH']+'/blocs',
          '${map['title']}_bloc');

      FileMaker().createDartFileAndWrite(
          BlocScreen().toCompleteStarterBlocScreen(map['title']),
          params['DESTINATION_FOLDER_PATH']+'/ui/screens',
          '${map['title']}_screen');
    }

    /// generate [bloc.dart]
    FileMaker().createDartFileAndWrite(
        MainBloc().toCompleteStarterMainBloc(),
        params['DESTINATION_FOLDER_PATH']+'/blocs',
        'bloc');

  }
}



class CliParser{

  ArgParser argParser = ArgParser();
  ArgResults argResults;
  List<String> arguments;

  CliParser(this.arguments);

  void createCommand() {
    argParser.addFlag("destination",
        abbr: "d",
        help: "add your lib path to generate the folder structure",
        defaultsTo: false,
    );

    argParser.addFlag("params",
      abbr: "p",
      help: "add your json file path to generate the BloCs pattern",
      defaultsTo: false,
    );
  }

  readArgs() {
    argResults = argParser.parse(arguments);
    if (argResults['destination'] && argResults['params'] && argResults.rest.isNotEmpty) {
      Map<String, dynamic> m = {
        "DESTINATION_FOLDER_PATH" : argResults.rest[0],
        "JSON_PATH" : argResults.rest[1]
      };
      return m;
    }
  }
}



// model pour observer le contenu d'un dossier excepté le dossier "cli"
// pour récupérer les noms de fichiers
class GenDirs{

  String basePath;
  final String blocsPath = '/blocs';
  final String uiScreenPath = '/ui/screens';

  String get blocsFullPath => basePath + blocsPath;
  String get uiScreenFullPath => basePath + uiScreenPath;

  GenDirs(String basePath){
    this.basePath = basePath;
    createDirs(blocsFullPath);
    createDirs(uiScreenFullPath);
  }

  Future<bool> checkDir(String path) async => await FileSystemEntity.isDirectory(path);

  void createDirs(String path) async{
    var isDir = await checkDir(basePath);
    print(path);

    if(isDir){
      var result = await Directory(path).create(recursive: true);
      if(result!=null) {
        print(result.path);
      }
    }
  }
}

class JsonParser{



  JsonParser();

}

class BlocRouter{

}

// model pour générer le boiler plate des blocs
class BlocBoilerPlate{

}

class BlocProvider{

}

class MainBloc{

  String toCompleteStarterMainBloc() =>
'''
abstract class Bloc{
  // without kind "void", it will be suggest
  void dispose();
}
''';
}

class Bloc{

  String toCompleteStarterBloc(String titleBloc, String type) =>
'''
import 'bloc.dart';
import 'dart:async';

class ${titleBloc[0].toUpperCase()}${titleBloc.substring(1)}Bloc extends Bloc {

  //change null value if you desire
  $type ${titleBloc.toLowerCase()};
  ${titleBloc[0].toUpperCase()}${titleBloc.substring(1)}Bloc() {
  //to implement constructor or not
  }
  final _streamController = StreamController<$type>();
  Sink<$type> get sink => _streamController.sink;
  Stream<$type> get stream => _streamController.stream;
  test(){
  //to implement logic
  }
  @override
  void dispose() => _streamController.close();
  
}''';
  }

class BlocScreen{

  String toCompleteStarterBlocScreen(String title) =>
'''
import 'package:flutter/material.dart';

class ${title[0].toUpperCase()}${title.substring(1)}Screen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';
}



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