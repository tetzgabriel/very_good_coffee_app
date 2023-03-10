import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/image_finder/image_finder.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(color: Color(0xFF2A48DE)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF2A48DE),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ImageFinderPage(),
    );
  }
}
