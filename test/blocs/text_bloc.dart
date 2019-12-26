import 'bloc.dart';
import 'dart:async';

class TextBloc extends Bloc {

  //change null value if you desire
  String text;
  TextBloc() {
  //to implement constructor or not
  }
  final _streamController = StreamController<String>();
  Sink<String> get sink => _streamController.sink;
  Stream<String> get stream => _streamController.stream;
  test(){
  //to implement logic
  }
  @override
  void dispose() => _streamController.close();
  
}