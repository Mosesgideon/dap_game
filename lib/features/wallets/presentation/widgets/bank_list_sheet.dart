import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/data/models/fetch_bank_response.dart';
import 'package:flutter/material.dart';
import 'package:dap_game/features/wallets/presentation/bloc/bank/bank_bloc.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankListSheet extends StatefulWidget {
  const BankListSheet({super.key, required this.countryCode});

  final String countryCode;

  @override
  State<BankListSheet> createState() => _BankListSheetState();
}

class _BankListSheetState extends State<BankListSheet> {
  // final bankBloc = BankBloc(FetchBankRepositoryImpl());
  // var allBanks = injector.get<BankBloc>().banks;

  List<BankData> filteredBanks = [];
  List<BankData> allBanks = [];

  @override
  void initState() {
    injector.get<BankBloc>().add(FetchBankEvent(widget.countryCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      constraints: BoxConstraints(maxHeight: 0.9.sh),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: Pallets.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          const TextView(
            text: "Select your Preferred bank",
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          10.verticalSpace,
          FilledTextField(
            hint: 'Search Banks',
            onChanged: (val) {
              filter(val!);
            },
          ),
          20.verticalSpace,
          Expanded(
            child: BlocConsumer<BankBloc, BankState>(
              listener: _listenToBankState,
              bloc: injector.get(),
              builder: (context, state) {
                if (state is FetchBankLoadingState) {
                  return CustomDialogs.getLoading(size: 30);
                }
                if (state is FetchBankFailiureState) {
                  return AppPromptWidget(
                    message: state.error,
                    title: 'Oops!',
                    onTap: () {
                      injector
                          .get<BankBloc>()
                          .add(FetchBankEvent(widget.countryCode));
                    },
                  );
                }

                if (filteredBanks.isNotEmpty) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: filteredBanks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  context.pop(filteredBanks[index]);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircleAvatar(
                                            backgroundColor: Pallets.grey90,
                                            child: Icon(
                                                Icons.account_balance_rounded)),
                                        10.horizontalSpace,
                                        Expanded(
                                          child: TextView(
                                            text: filteredBanks[index]
                                                .name
                                                .toString(),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const AppPromptWidget(
                    title: 'No Banks',
                    canTryAgain: false,
                    message: '',
                  );
                }

                return 0.verticalSpace;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _listenToBankState(BuildContext context, BankState state) {
    if (state is FetchBankLoadingState) {
      // return CustomDialogs.showLoading(context);
    }
    if (state is FetchBankSuccessState) {
      filteredBanks = state.response.data;
      allBanks = state.response.data;
    }
    if (state is FetchBankFailiureState) {}

    filteredBanks = injector.get<BankBloc>().banks;
    allBanks = injector.get<BankBloc>().banks;
    setState(() {});
  }

  void filter(String val) {
    setState(() {
      if (val.isNotEmpty) {
        filteredBanks = allBanks
            .where((element) =>
                element.name!.toLowerCase().contains(val.toLowerCase()))
            .toList();
      } else {
        filteredBanks = allBanks;
      }
    });
  }
}
