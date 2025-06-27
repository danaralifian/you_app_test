import 'package:flutter/material.dart';

class InterestInput extends StatefulWidget {
  const InterestInput({super.key});

  @override
  State<InterestInput> createState() => _InterestInputState();
}

class _InterestInputState extends State<InterestInput> {
  final List<String> _interests = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addInterest(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !_interests.contains(trimmed)) {
      setState(() => _interests.add(trimmed));
    }
    _controller.clear();
  }

  void _removeInterest(String interest) {
    setState(() => _interests.remove(interest));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(217, 217, 217, 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ..._interests.map(
                (interest) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        interest,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _removeInterest(interest),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, wrapConstraints) {
                  // calculate available width
                  double usedWidth = 0;
                  const spacing = 8;

                  for (var interest in _interests) {
                    // estimate width of each interest
                    usedWidth += (interest.length * 8 + 48) + spacing;
                  }

                  final double availableWidth =
                      wrapConstraints.maxWidth - usedWidth;

                  final double inputWidth = availableWidth > 100
                      ? availableWidth
                      : wrapConstraints.maxWidth;

                  return SizedBox(
                    width: inputWidth,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onSubmitted: _addInterest,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
