import 'package:flutter/widgets.dart';

class GoldText extends StatelessWidget {
  final Widget child;

  const GoldText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF94783E),
            Color(0xFFF3EDA6),
            Color(0xFFFFE2BE),
            Color(0xFFD5BE88),
            Color(0xFFD5BE88),
            Color(0xFFFFE2BE),
          ],
          stops: [0.0, 0.1676, 0.3209, 0.4109, 0.9660, 0.8901],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
