import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/results/presentation/widgets/number_result_widget.dart';
import 'package:flutter/material.dart';

class NumbersResults extends StatefulWidget {
  const NumbersResults({super.key});

  @override
  State<NumbersResults> createState() => _NumbersResultsState();
}

class _NumbersResultsState extends State<NumbersResults> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            23.verticalSpace,
            NumberWidget(),
            18.verticalSpace,
            TextView(text: "Yesterday Results",
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue),),
            12.verticalSpace,
            NumberWidget(),

          ],
        ),
      ),
    );
  }
}
