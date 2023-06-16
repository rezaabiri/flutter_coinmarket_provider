
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_provider/providers/ThemeProvider.dart';
import 'package:project_provider/ui/MainWrapper.dart';
import 'package:project_provider/ui/ui_helper/ThemeSwither.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('fa'), // Spanish
        ],
        home: MyHomePage()
      )
    )
  );
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.liteTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,

          home: const Directionality(
            textDirection: TextDirection.ltr,
            child: MainWrapper(),
          ),
        );
      },
    );
  }
}
