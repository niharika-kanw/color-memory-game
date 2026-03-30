import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../widgets/app_shell.dart';
import '../widgets/color_pad.dart';
import 'user_input_screen.dart';

class SequencePlaybackScreen extends StatefulWidget {
  const SequencePlaybackScreen({super.key, required this.gameState});

  final GameState gameState;

  @override
  State<SequencePlaybackScreen> createState() => _SequencePlaybackScreenState();
}

class _SequencePlaybackScreenState extends State<SequencePlaybackScreen> {
  int _activeIndex = -1;
  bool _cancelled = false;

  @override
  void initState() {
    super.initState();
    _playSequence();
  }

  @override
  void dispose() {
    _cancelled = true;
    super.dispose();
  }

  Future<void> _playSequence() async {
    final int r = widget.gameState.round;
    final int onMs = flashOnDurationMs(r);
    final int gapMs = flashGapDurationMs(r);

    for (int i = 0; i < widget.gameState.sequence.length; i++) {
      if (_cancelled || !mounted) {
        return;
      }
      setState(() => _activeIndex = i);
      await Future<void>.delayed(Duration(milliseconds: onMs));
      if (_cancelled || !mounted) {
        return;
      }
      setState(() => _activeIndex = -1);
      await Future<void>.delayed(Duration(milliseconds: gapMs));
    }

    if (_cancelled || !mounted) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (_cancelled || !mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => UserInputScreen(gameState: widget.gameState),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int r = widget.gameState.round;
    final int onMs = flashOnDurationMs(r);
    final int gapMs = flashGapDurationMs(r);

    return AppShell(
      title: 'Sequence Playback',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Round $r',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Watch the sequence — colors change each round and get faster.',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Flash ${onMs}ms · gap ${gapMs}ms',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: GameColor.values.asMap().entries.map((entry) {
              final bool isHighlighted = _activeIndex >= 0 &&
                  widget.gameState.sequence[_activeIndex] == entry.value;
              return ColorPad(
                gameColor: entry.value,
                baseColor: ColorPalettes.color(entry.value, widget.gameState.paletteIndex),
                onTap: () {},
                highlighted: isHighlighted,
                enabled: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
