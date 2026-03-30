import 'package:flutter/material.dart';
import 'models/game_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GameState _gameState = GameState();

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3B82F6),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0B1120),
    );

    final TextTheme t = base.textTheme.apply(
      fontFamily: 'Manrope',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );

    final TextTheme textTheme = t.copyWith(
      displayLarge: t.displayLarge?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w800),
      displayMedium: t.displayMedium?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w800),
      displaySmall: t.displaySmall?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w800),
      headlineLarge: t.headlineLarge?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w700),
      headlineMedium: t.headlineMedium?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w700),
      headlineSmall: t.headlineSmall?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w700),
      titleLarge: t.titleLarge?.copyWith(fontFamily: 'Sora', fontWeight: FontWeight.w600),
    );

    return MaterialApp(
      title: 'Color Memory Game',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: textTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF111827),
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white30),
            textStyle: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF93C5FD),
            textStyle: const TextStyle(
              fontFamily: 'Sora',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      home: HomeScreen(gameState: _gameState),
    );
  }
}
