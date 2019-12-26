import 'dart:convert';
import 'dart:io';
import 'package:cli/models/bloc.dart';
import 'package:cli/models/bloc_provider.dart';
import 'package:cli/models/bloc_screen.dart';
import 'package:cli/models/cli_parser.dart';
import 'package:cli/models/generate_directories.dart';
import 'package:cli/models/main_bloc.dart';

import '../lib/models/bloc_router.dart';
import '../lib/models/file_maker.dart';

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
    GenerateDirectories(params['DESTINATION_FOLDER_PATH']);

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

    /// generate [bloc_provider.dart]
    FileMaker().createDartFileAndWrite(
        BlocProvider().toCompleteStarterBlocProvider(),
        params['DESTINATION_FOLDER_PATH']+'/blocs',
        'bloc_provider');

    FileMaker().createDartFileAndWrite(
        BlocRouter().toCompleteStarterBlocRouter(),
        params['DESTINATION_FOLDER_PATH']+'/blocs',
        'bloc_router');

    print("SUCCESSFULLY INSTALLED");
  }
}
