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