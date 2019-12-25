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