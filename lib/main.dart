import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'models/crop.dart';
import 'providers/crop_provider.dart';
import 'screens/home_screen.dart';
// import 'screens/harvest_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/crop_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  void _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSignedIn = prefs.getBool('isSignedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CropProvider(),
      child: MaterialApp(
        title: 'Farm Buddy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode:
            ThemeMode.system, // Automatically switch based on system setting
        initialRoute: _isSignedIn ? '/home' : '/',
        routes: _isSignedIn
            ? {
                '/': (context) => HomeScreen(),
                // '/harvest': (context) => HarvestScreen(),
                '/crop_list': (context) => CropListScreen(),
              }
            : {
                '/': (context) => SignInScreen(),
              },
      ),
    );
  }
}
