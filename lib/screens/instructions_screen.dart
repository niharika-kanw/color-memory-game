import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';
import 'sequence_playback_screen.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Instructions',
      child: Card(
        elevation: 8,
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'How to Play',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              _rule(context, 'Watch the flashing sequence carefully.'),
              _rule(context, 'Click the four color pads in exactly the same order.'),
              _rule(context, 'Each round adds one new random color.'),
              _rule(context, 'A wrong click ends the game immediately.'),
              _rule(context, 'Build the longest streak and beat your high score.'),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 300,
                  child: FilledButton(
                    onPressed: () {
                      gameState.startNewGame();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              SequencePlaybackScreen(gameState: gameState),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Begin'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rule(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 4, right: 10),
            child: Icon(Icons.circle, size: 10, color: Colors.white70),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
