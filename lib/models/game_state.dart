import 'dart:math';
import 'package:flutter/material.dart';

enum GameColor { red, blue, green, yellow }

class ColorPalettes {
  ColorPalettes._();

  static const List<List<int>> _argb = <List<int>>[
    <int>[0xFFE53935, 0xFF1E88E5, 0xFF43A047, 0xFFFDD835],
    <int>[0xFF7C3AED, 0xFFEC4899, 0xFF06B6D4, 0xFFF59E0B],
    <int>[0xFFBE185D, 0xFF0891B2, 0xFF059669, 0xFFD97706],
    <int>[0xFFDC2626, 0xFF2563EB, 0xFF16A34A, 0xFFEAB308],
    <int>[0xFFEA580C, 0xFF6366F1, 0xFF0D9488, 0xFFFACC15],
    <int>[0xFFDB2777, 0xFF1D4ED8, 0xFF15803D, 0xFFCA8A04],
    <int>[0xFFEF4444, 0xFF3B82F6, 0xFF22C55E, 0xFFEAB308],
    <int>[0xFFC026D3, 0xFF0EA5E9, 0xFF84CC16, 0xFFFBBF24],
  ];

  static int get count => _argb.length;

  static Color color(GameColor gameColor, int paletteIndex) {
    final List<int> row = _argb[paletteIndex % _argb.length];
    return Color(row[gameColor.index]);
  }
}

extension GameColorX on GameColor {
  Color get color {
    return ColorPalettes.color(this, 0);
  }

  String get label {
    switch (this) {
      case GameColor.red:
        return 'Red';
      case GameColor.blue:
        return 'Blue';
      case GameColor.green:
        return 'Green';
      case GameColor.yellow:
        return 'Yellow';
    }
  }
}

int flashOnDurationMs(int round) {
  return (520 - round * 28).clamp(115, 520);
}

int flashGapDurationMs(int round) {
  return (240 - round * 14).clamp(40, 240);
}

enum InputStatus { inProgress, correct, incorrect }

class RoundRecord {
  const RoundRecord({
    required this.round,
    required this.correct,
    required this.scoreAfterRound,
  });

  final int round;
  final bool correct;
  final int scoreAfterRound;
}

class GameState {
  final Random _random = Random();
  final List<GameColor> sequence = <GameColor>[];
  final List<RoundRecord> recentRounds = <RoundRecord>[];

  int round = 0;
  int score = 0;
  int highScore = 0;
  int paletteIndex = 0;

  void startNewGame() {
    sequence.clear();
    round = 1;
    score = 0;
    _pickPalette();
    _addRandomColor();
  }

  void prepareNextRound() {
    round += 1;
    _pickPalette();
    _addRandomColor();
  }

  void _pickPalette() {
    paletteIndex = _random.nextInt(ColorPalettes.count);
  }

  InputStatus checkInput(List<GameColor> userInput) {
    for (int i = 0; i < userInput.length; i++) {
      if (userInput[i] != sequence[i]) {
        return InputStatus.incorrect;
      }
    }

    if (userInput.length == sequence.length) {
      return InputStatus.correct;
    }

    return InputStatus.inProgress;
  }

  void completeRound({required bool correct}) {
    if (correct) {
      score += 10;
      if (score > highScore) {
        highScore = score;
      }
    }

    recentRounds.insert(
      0,
      RoundRecord(round: round, correct: correct, scoreAfterRound: score),
    );

    if (recentRounds.length > 10) {
      recentRounds.removeRange(10, recentRounds.length);
    }
  }

  void _addRandomColor() {
    sequence.add(GameColor.values[_random.nextInt(GameColor.values.length)]);
  }
}
