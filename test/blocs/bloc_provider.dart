import 'package:flutter/material.dart';
import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget{

  // which bloc ?
  final T bloc;

  // which child ?
  final Widget child;

  // which constructor ?
  BlocProvider({@required this.bloc, @required this.child});

  static T of<T extends Bloc>(BuildContext context){
    final BlocProvider _provider = context.findAncestorWidgetOfExactType();
    return _provider.bloc;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BlocProviderState();
  }
}

class _BlocProviderState extends State<BlocProvider>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}
