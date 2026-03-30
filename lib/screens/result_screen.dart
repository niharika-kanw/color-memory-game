import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';
import 'home_screen.dart';
import 'score_history_screen.dart';
import 'sequence_playback_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.gameState,
    required this.correct,
  });

  final GameState gameState;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = correct ? const Color(0xFF22C55E) : const Color(0xFFEF4444);
    final String title = correct ? 'Correct!' : 'Game Over';
    final String subtitle = correct
        ? 'Great memory. Ready for a longer sequence?'
        : 'Wrong sequence entered. Try again and beat your best score.';

    return AppShell(
      title: 'Round Result',
      child: Card(
        elevation: 8,
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Icon(
                correct ? Icons.check_circle : Icons.cancel,
                color: statusColor,
                size: 62,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _scoreTile(context, 'Score', '${gameState.score}'),
              const SizedBox(height: 10),
              _scoreTile(context, 'Round Reached', '${gameState.round}'),
              const SizedBox(height: 22),
              SizedBox(
                width: 320,
                child: FilledButton(
                  onPressed: () {
                    if (correct) {
                      gameState.prepareNextRound();
                    } else {
                      gameState.startNewGame();
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => SequencePlaybackScreen(gameState: gameState),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(correct ? 'Next Round' : 'Retry'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 320,
                child: OutlinedButton(
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
                    child: Text('View Score & History'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 320,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => HomeScreen(gameState: gameState),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Home'),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreTile(BuildContext context, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
