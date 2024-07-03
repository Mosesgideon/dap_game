import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
class CountryWidget extends StatefulWidget {
  const CountryWidget({super.key});

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>  Padding(
          padding: EdgeInsets.symmetric(vertical: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageWidget(imageUrl: Assets.images.pngs.nigeria.path),
                  10.horizontalSpace,
                  const TextView(
                    text: "Nigeria",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Pallets.black),
                  ),
                ],
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
