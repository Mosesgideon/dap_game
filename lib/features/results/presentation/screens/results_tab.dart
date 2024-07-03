import 'package:dap_game/common/widgets/action_button.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/results/presentation/screens/country_result.dart';
import 'package:dap_game/features/results/presentation/screens/number_result.dart';
import 'package:dap_game/features/results/presentation/screens/word_results.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  // with SingleTickerProviderStateMixin
  late TabController tabController;

  @override
  void initState() {
    // tabController=TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // leadingWidth: 20,
          elevation: 0,
          title: const Text(
            "Results",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Pallets.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Current Results",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Pallets.darkblue),
                  ),
                  CustomActionButton(
                    size: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImageWidget(imageUrl: Assets.images.pngs.filter.path),
                    ),
                    onTap: () {},
                  )
                ], //
              ),
              15.verticalSpace,
              const TabBar(
                padding: EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelColor: Pallets.darkblue,
                indicatorColor: Pallets.orange,
                labelColor: Pallets.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(vertical: 5),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                tabs: [
                  Text(
                    "Numbers",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Pallets.darkblue),
                  ),
                  Text("Country",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Pallets.darkblue)),
                  Text("Words",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Pallets.darkblue)),
                ],
              ),
              16.verticalSpace,
              const Expanded(
                child: TabBarView(
                  children: [
                    NumbersResults(),
                    CountryResults(),
                    WordsResults()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
