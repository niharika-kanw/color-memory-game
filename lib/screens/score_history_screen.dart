import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';

class ScoreHistoryScreen extends StatelessWidget {
  const ScoreHistoryScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Score & History',
      child: Card(
        elevation: 8,
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _scoreBox(context, 'Current Score', '${gameState.score}'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _scoreBox(context, 'High Score', '${gameState.highScore}'),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Rounds',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: gameState.recentRounds.isEmpty
                    ? Center(
                        child: Text(
                          'No rounds played yet.',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: gameState.recentRounds.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (BuildContext context, int index) {
                          final RoundRecord record = gameState.recentRounds[index];
                          final bool ok = record.correct;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F2937),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  ok ? Icons.check_circle : Icons.cancel,
                                  color: ok ? const Color(0xFF22C55E) : const Color(0xFFEF4444),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Round ${record.round}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Score: ${record.scoreAfterRound}',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scoreBox(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
