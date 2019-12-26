import 'bloc.dart';
import 'dart:async';

class CounterBloc extends Bloc {

  //change null value if you desire
  Map<String, dynamic> counter;
  CounterBloc() {
  //to implement constructor or not
  }
  final _streamController = StreamController<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get sink => _streamController.sink;
  Stream<Map<String, dynamic>> get stream => _streamController.stream;
  test(){
  //to implement logic
  }
  @override
  void dispose() => _streamController.close();
  
}