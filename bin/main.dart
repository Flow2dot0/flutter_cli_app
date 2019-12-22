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

    /// Read the json file
    String jsonData = await File(params['JSON_PATH']).readAsStringSync();
    var jsonMap = jsonDecode(jsonData);
    print(jsonMap);
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

class Bloc{

}

class BlocScreen{

}



class FileMaker{

}