import 'package:flutter/material.dart';
import 'package:install_inspect/src/providers/providers.dart';
import 'package:install_inspect/src/screens/screens.dart';
import 'package:provider/provider.dart';

// IMPORTACIONES DE FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FugaProvider()),
        ChangeNotifierProvider(create: (context) => ReparadoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Departamento TI',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'formInstalacion': (_) => FormularioInstalacionScreen(),
          'formInspeccion': (_) => const FormularioInspeccionScreen()
        },
      ),
    );
  }
}
