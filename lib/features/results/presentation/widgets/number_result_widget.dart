import 'package:flutter/material.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/theme/pallets.dart';

class NumberWidget extends StatefulWidget {
  const NumberWidget({super.key});

  @override
  State<NumberWidget> createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: "20",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Pallets.black),
                  ),
                  Icon(
                    Icons.check,
                    color: Pallets.primaryDark,
                    size: 20,
                  ),
                ],
              ),
            ));
  }
}
