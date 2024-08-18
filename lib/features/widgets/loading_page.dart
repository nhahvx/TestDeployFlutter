import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_ai/generated/extension.dart';

class AnimationLoading extends StatefulWidget {
  final String urlFromAssets;
  const AnimationLoading({super.key, required this.urlFromAssets});

  @override
  State<AnimationLoading> createState() => _AnimationLoadingState();
}

class _AnimationLoadingState extends State<AnimationLoading> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE0D8FF).withOpacity(1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(widget.urlFromAssets),
            const SizedBox(height: 32,),
            WaveText(context.loc.loading),
          ],
        ),
      ),
    );
  }
}

class WaveText extends StatefulWidget {
  final String text;
  const WaveText(this.text, {super.key});

  @override
  State<WaveText> createState() => _WaveTextState();
}

class _WaveTextState extends State<WaveText> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Text.rich(
          TextSpan(
            children: widget.text.split('').asMap().entries.map((entry) {
              int index = entry.key;
              String letter = entry.value;
              final double offset = (index - (_controller.value * widget.text.length)).abs();
              final double scale = 1 - (offset * 0.03).clamp(0.0, 1.0);
              return WidgetSpan(
                child: Transform.scale(
                  scale: scale,
                  child: Text(letter, style: const TextStyle(fontSize: 32, color: Colors.black)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}