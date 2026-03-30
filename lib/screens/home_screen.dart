import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';
import 'instructions_screen.dart';
import 'score_history_screen.dart';
import 'sequence_playback_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Color Memory Game',
      child: Card(
        elevation: 8,
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Color Memory Game',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Repeat each color sequence perfectly as the rounds get longer.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: 320,
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
                    child: Text('Start Game'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 320,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => InstructionsScreen(gameState: gameState),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Instructions'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 320,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => ScoreHistoryScreen(gameState: gameState),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Score & History'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
