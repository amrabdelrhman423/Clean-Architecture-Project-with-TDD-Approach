import 'package:flutter/material.dart';
import 'package:tdd/features/number_trivia/presentation/Pages/number_trivia_page.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';
import 'core/network/network_info.dart';
import 'injection_container.dart' as dependency_injection;
 main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Flutter ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: NumberTriviaPage(),
    );
  }
}
