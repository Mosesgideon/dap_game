import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FundCard extends StatefulWidget {
  const FundCard({super.key});

  @override
  State<FundCard> createState() => _FundCardState();
}

class _FundCardState extends State<FundCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            leading: Icon(
              Icons.arrow_back_ios_new,
              size: 17,
            ),
            tittle: Text(
              "Fund With Card",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue),
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Please enter amount and your card details",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Pallets.darkblue),
                    ),
                    20.verticalSpace,
                    const FilledTextField(
                      hint: "Amount", preffix: Icon(Iconsax.user),),
                    20.verticalSpace,
                    const FilledTextField(
                      hint: "Card holder name", preffix: Icon(Iconsax.user),),
                    20.verticalSpace,
                    const FilledTextField(
                      hint: "Card number", preffix: Icon(Iconsax.user),),
                    20.verticalSpace,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 150,
                            child: FilledTextField(
                              hint: "Card number", preffix: Icon(Iconsax.user),),

                        ),

                        SizedBox(
                            width: 150,
                            child: FilledTextField(
                              hint: "Card number", preffix: Icon(Iconsax.user),),
                        ),
                      ],
                    ),
                    50.verticalSpace,
                    CustomButton(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        borderRadius: BorderRadius.circular(25),
                        bgColor: Pallets.orange,
                        child: const TextView(
                          text: "Confirm Payment",
                        ),
                        onPressed: () {
                          // context.pushNamed(PageUrl.fund_success);
                        }),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
