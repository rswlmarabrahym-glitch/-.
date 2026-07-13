import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/engine_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const DieselEngineApp());
  });
}

class DieselEngineApp extends StatelessWidget {
  const DieselEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diesel Engine Marketplace',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)).copyWith(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const EngineListScreen(),
    );
  }
}
