import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:flutter/material.dart';

class FundBank extends StatefulWidget {
  const FundBank({super.key});

  @override
  State<FundBank> createState() => _FundBankState();
}

class _FundBankState extends State<FundBank> {
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
              "Fund Through Bank Transfer",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Pallets.darkblue),
            ),
          ),
          35.verticalSpace,
          const TextView(
            text:
                "Please copy your Dap game ID to fun your account through your bank mobile app",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          20.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: 1.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallets.white,
                boxShadow: [
                  BoxShadow(
                      color: Pallets.grey.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(1, 1))
                ]),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextView(
                        text: "Account Name",
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Pallets.darkblue,
                      ),
                      6.verticalSpace,
                      const TextView(
                        text: "Diala Victor",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Pallets.grey,
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Account ID",
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Pallets.darkblue,
                          ),
                          6.verticalSpace,
                          const TextView(
                            text: "G1253647",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Pallets.grey,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Pallets.darkblue,
                              ),
                            )),
                        child: const Text("Copy"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
