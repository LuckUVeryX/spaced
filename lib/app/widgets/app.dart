import 'package:flutter/material.dart';
import 'package:spaced/l10n/l10n.dart';
import 'package:spaced/spaced/widgets/spaced_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(),
    );
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: inputDecorationTheme,
      ),
      darkTheme: ThemeData.dark().copyWith(
        inputDecorationTheme: inputDecorationTheme,
      ),
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const SpacedPage(),
    );
  }
}
