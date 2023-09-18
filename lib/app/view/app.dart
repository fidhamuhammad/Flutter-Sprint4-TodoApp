import 'package:flutter/material.dart';
import 'package:todoapp/l10n/l10n.dart';
import 'package:todoapp/splashscreen/view/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 225, 133, 245)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Color.fromARGB(255, 198, 120, 234),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SplashScreen(),
    );
  }
}
