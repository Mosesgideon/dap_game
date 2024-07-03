import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class PopUpBottomSheet extends StatefulWidget {
  const PopUpBottomSheet({super.key});

  @override
  State<PopUpBottomSheet> createState() => _PopUpBottomSheetState();
}

class _PopUpBottomSheetState extends State<PopUpBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              25,
            ),
            topRight: Radius.circular(25),
          ),
          color: Pallets.mildBlue),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          //     BoxShadow(
          //         color: Pallets.white,
          //         offset: Offset(2, 2),
          //         spreadRadius: 2,
          //         blurRadius: 2)
          //   ]),
          //   child: const TextView(text: "Choose New Picture",
          //       fontSize: 18,
          //       fontWeight: FontWeight.w500 ,),
          // )
          10.verticalSpace,
          _bottomSheetItem(
              title: 'Choose New Picture',
              voidCallback: () {},
              color: Pallets.white),
          _bottomSheetItem(
              title: 'Choose New Picture',
              voidCallback: () {},
              color: Pallets.white),
          _bottomSheetItem(
              title: 'Edit Name',
              voidCallback: () {
                Navigator.pop(context);
                context.pushNamed(PageUrl.details_edit);
              },
              color: Pallets.white),
          _bottomSheetItem(
              title: 'Cancel',
              voidCallback: () {
                Navigator.pop(context);
              },
              color: Pallets.mildBlue),
        ],
      ),
    );
  }

  _bottomSheetItem(
      {required String title,
      required VoidCallback voidCallback,
      required Color color}) {
    return SizedBox(
      height: 70,
      width: 1.sw,
      child: InkWell(
        onTap: voidCallback,
        child: Card(
          elevation: 0,
          color: color,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Center(
              child: TextView(
                text: title,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
