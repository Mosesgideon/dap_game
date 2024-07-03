import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/results/presentation/widgets/words_result_widget.dart';
import 'package:flutter/material.dart';
class WordsResults extends StatefulWidget {
  const WordsResults({super.key});

  @override
  State<WordsResults> createState() => _WordsResultsState();
}

class _WordsResultsState extends State<WordsResults> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WordResultWidget(),
          20.verticalSpace,
          const TextView(text: "Yesterday Results",
            style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Pallets.darkblue),),
          10.verticalSpace,
         const WordResultWidget()
        ],
      ),
    );
  }
}
