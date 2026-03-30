import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';
import '../widgets/color_pad.dart';
import 'result_screen.dart';

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final List<GameColor> _userInput = <GameColor>[];
  bool _locked = false;

  Future<void> _onColorTap(GameColor color) async {
    if (_locked) {
      return;
    }

    setState(() {
      _userInput.add(color);
    });

    final InputStatus result = widget.gameState.checkInput(_userInput);
    if (result == InputStatus.inProgress) {
      return;
    }

    _locked = true;
    final bool correct = result == InputStatus.correct;
    widget.gameState.completeRound(correct: correct);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ResultScreen(gameState: widget.gameState, correct: correct),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Your Turn',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Round ${widget.gameState.round}',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Repeat the full sequence',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Progress: ${_userInput.length} / ${widget.gameState.sequence.length}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: GameColor.values.map((GameColor gameColor) {
              return ColorPad(
                gameColor: gameColor,
                baseColor: ColorPalettes.color(
                  gameColor,
                  widget.gameState.paletteIndex,
                ),
                onTap: () => _onColorTap(gameColor),
                highlighted: false,
                enabled: !_locked,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
