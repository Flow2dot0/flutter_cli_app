import 'package:args/args.dart';

class CliParser{

  ArgParser argParser = ArgParser();
  ArgResults argResults;
  List<String> arguments;

  CliParser(this.arguments);

  void createCommand() {
    /// create destination -d command
    argParser.addFlag("destination",
      abbr: "d",
      help: "add your lib path to generate the folder structure",
      defaultsTo: false,
    );

    /// create params -p command
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