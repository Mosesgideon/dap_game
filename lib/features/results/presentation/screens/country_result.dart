import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/results/presentation/widgets/country_widget.dart';
import 'package:flutter/material.dart';

class CountryResults extends StatefulWidget {
  const CountryResults({super.key});

  @override
  State<CountryResults> createState() => _CountryResultsState();
}

class _CountryResultsState extends State<CountryResults> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CountryWidget(),
            23.verticalSpace,
            const TextView(
              text: "Yesterday Results",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue),
            ),
            10.verticalSpace,
            const CountryWidget()
          ],
        ),
      ),
    );
  }
}
