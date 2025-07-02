import 'package:flutter/material.dart';

class InterestInput extends StatefulWidget {
  final void Function(List<String> value) onChange;
  final List<String>? value;

  const InterestInput({
    super.key,
    required this.onChange,
    this.value = const [],
  });

  @override
  State<InterestInput> createState() => _InterestInputState();
}

class _InterestInputState extends State<InterestInput> {
  List<String> _interests = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _interests = List.from(widget.value ?? []);
  }

  void _addInterest(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty && !_interests.contains(trimmed)) {
      setState(() {
        _interests.add(trimmed);
        widget.onChange(_interests);
      });
    }
    _controller.clear();
  }

  void _removeInterest(String interest) {
    setState(() {
      _interests.remove(interest);
      widget.onChange(_interests);
    });
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
            spacing: 8.0,
            runSpacing: 8.0,
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
              // Adaptive TextField
              Builder(
                builder: (context) {
                  final textScale = MediaQuery.textScalerOf(context).scale(1.0);
                  double usedWidth = 0;
                  const double spacing = 8.0;

                  for (var interest in _interests) {
                    final tagWidth =
                        (interest.length * 8 * textScale) + 48 + spacing;
                    usedWidth += tagWidth;
                  }

                  final double availableWidth =
                      constraints.maxWidth - usedWidth;
                  final double inputWidth = availableWidth > 100
                      ? availableWidth
                      : constraints.maxWidth;

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: inputWidth,
                    ),
                    child: IntrinsicWidth(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onSubmitted: _addInterest,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Add interest',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
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
