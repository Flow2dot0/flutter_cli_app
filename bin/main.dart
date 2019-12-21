import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async{


  var cliParser = CliParser(arguments)
    ..createCommand()
    ..readCommand();

  GenDirs(cliParser.path);

  var test = await File('../lib/config/params.json').openRead();
  print(test.first);

}

class CliParser{

  ArgParser argParser = ArgParser();
  ArgResults argResults;
  List<String> arguments;
  String path;

  CliParser(this.arguments);

  void createCommand() {
    argParser.addFlag("pathlib",
        abbr: "p",
        help: "add your lib path to generate the BloCs pattern",
        defaultsTo: false,
    );
  }

  void readCommand() {
    argResults = argParser.parse(arguments);
    if (argResults['pathlib'] && argResults.rest.isNotEmpty) {
      path =  argResults.rest[0];
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