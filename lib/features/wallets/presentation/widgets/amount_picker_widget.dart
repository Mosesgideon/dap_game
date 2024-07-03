import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:flutter/material.dart';

class AmountPickerWidget extends StatefulWidget {
  const AmountPickerWidget({
    Key? key,
    required this.onSelected,
    this.amounts = const ['0.5', '1', '5', "10", "20", "50"],
  }) : super(key: key);

  final Function(String value) onSelected;
  final List? amounts;

  @override
  State<AmountPickerWidget> createState() => _AmountPickerWidgetState();
}

class _AmountPickerWidgetState extends State<AmountPickerWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 10,
        spacing: 6,
        children: List.generate(
            widget.amounts!.length,
            (index) => InkWell(
                  onTap: () {
                    widget.onSelected(widget.amounts![index].toString());
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: selectedIndex == index
                                ? Theme.of(context).colorScheme.onBackground
                                : Pallets.grey75),
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 12),
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.amounts![index].toString(),
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Theme.of(context).colorScheme.onBackground
                              : Pallets.grey75,
                          fontSize: 14),
                    ),
                  ),
                )),
      ),
    );
  }
}

List<int> createNumberList(int min, int max, {int count = 7}) {
  if (min < 0 || max < min) {
    throw ArgumentError(
        'Invalid range. Minimum cannot be negative and must be less than or equal to maximum.');
  }

  if (count <= 0) {
    throw ArgumentError('Count cannot be zero or negative.');
  }

  final difference = max - min;
  final isThousands = difference >= 10000;

  if (isThousands) {
    // Handle range in thousands, ensure count doesn't exceed range
    final maxCount = (max - min) ~/ 1000 + 1;
    final actualCount = count > maxCount ? maxCount : count;

    final start = min ~/ 1000;
    final step =
        (max - min) ~/ (actualCount - 1) + 1; // Adjust step based on count

    return List.generate(actualCount, (i) => (start + i * step) * 1000);
  } else {
    // Handle normal range, ensure count doesn't exceed range
    final actualCount = count > difference + 1 ? difference + 1 : count;

    return List.generate(actualCount, (i) => min + i);
  }
}
