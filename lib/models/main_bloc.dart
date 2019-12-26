class MainBloc{

  String toCompleteStarterMainBloc() =>
      '''
abstract class Bloc{
  // without kind "void", it will be suggest
  void dispose();
}
''';
}