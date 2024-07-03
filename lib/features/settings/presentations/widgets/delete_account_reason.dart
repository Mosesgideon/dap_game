import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeletReason extends StatefulWidget {
  final Function(String) onReasonSelected;

  const DeletReason({super.key, required this.onReasonSelected});

  @override
  State<DeletReason> createState() => _DeletReasonState();
}

class _DeletReasonState extends State<DeletReason> {
  final List<String> reasons = [
    "I never win anything",
    "I don't ike the app",
    "Something was broken",
    "I have a privacy concern",
    "Created a second account",
    "Not satisfied with the services",
    "Other"
  ];

  String selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    // bool checked=reasons.toString();
    return Container(
      // height: 300,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              25,
            ),
            topRight: Radius.circular(25),
          ),
          color: Pallets.mildBlue),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextView(
            text: "It's sad to see you make this decision!",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Pallets.darkblue,
          ),
          10.verticalSpace,
          const TextView(
            align: TextAlign.start,
            text:
                "It's qiute unfortunate to see you go,please before you continue,we would like you to tell us why you want to delete your account so we can improve your application !",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Pallets.darkblue,
          ),
          20.verticalSpace,
          ListView.builder(
            itemCount: reasons.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = selectedCategory == reasons[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = reasons[index];
                  });
                  widget.onReasonSelected(reasons[index]);
                  Future.delayed(
                    const Duration(
                      seconds: 1,
                    ),
                        () {
                     Navigator.pop(context);
                    },
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      CustomCheckBox(
                        onChecked: (bool val) {
                          // _rememberMe = val;
                          // setState(() {});
                        },
                        checkedColor:
                            isSelected ? Pallets.darkblue : Pallets.grey,
                        value: isSelected,
                      ),
                      TextView(
                        text: reasons[index],
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Pallets.darkblue,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
