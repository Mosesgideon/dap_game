import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';
class WordResultWidget extends StatefulWidget {
  const WordResultWidget({super.key});

  @override
  State<WordResultWidget> createState() => _WordResultWidgetState();
}

class _WordResultWidgetState extends State<WordResultWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>  const Padding(
          padding: EdgeInsets.symmetric(vertical: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Success",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Pallets.darkblue),
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
