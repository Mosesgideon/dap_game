import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/core/utils/string_extension.dart';
import 'package:dap_game/core/utils/validators.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_response.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/features/wallets/presentation/screens/add_beneficiary_account.dart';
import 'package:dap_game/features/wallets/presentation/widgets/beneficiarylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final _amountController = TextEditingController();
  bool check = false;
  Beneficary? selectedBeneficiary;
  final _bloc = WalletBloc(injector.get());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Withdraw Money",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: _listenToWalletBloc,
        bloc: _bloc,
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const WalletAppBar(),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Center(
                            child: Column(
                              children: [
                                const TextView(
                                  text: "Amount",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Pallets.black,
                                ),
                                5.verticalSpace,
                                SizedBox(
                                  width: 250,
                                  child: FilledTextField(
                                    inputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    hint: "\$0.0",
                                    validator: MultiValidator([
                                      MinAmountValidator(
                                          errorText:
                                              'Withdrawal should be greater than USD10',
                                          minAmount: 1),
                                      RequiredValidator(
                                          errorText: 'Enter amount')
                                    ]).call,
                                    contentPadding: const EdgeInsets.all(16),
                                    controller: _amountController,
                                  ),
                                ),
                                20.verticalSpace,
                                TextView(
                                  text:
                                      "\$${injector.get<UserBloc>().appUser?.wallet.balance.toString().formatAmount()}",
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Pallets.primary,
                                ),
                                const TextView(
                                  text: "Available Balance",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Pallets.primary,
                                ),
                              ],
                            ),
                          ),
                          40.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.wallet,
                                    size: 18,
                                  ),
                                  10.horizontalSpace,
                                  const TextView(
                                    text: "Withdraw Money to",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Pallets.primary,
                                  ),
                                ],
                              ),
                              CustomButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  isExpanded: false,
                                  // bgColor: Pallets.primaryLight.withOpacity(0.),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Iconsax.add,
                                      ),
                                      TextView(text: "Add Bank"),
                                    ],
                                  ),
                                  onPressed: () {
                                    CustomDialogs.showBottomSheet(
                                        context, const AddBeneficiaryScreen());
                                  })
                            ],
                          ),
                          30.verticalSpace,
                          const TextView(
                            text: "Beneficiaries",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Pallets.primary,
                          ),
                          5.verticalSpace,
                          BeneficiaryList(
                            onBeneficiarySelected: (Beneficary beneficiary) {
                              selectedBeneficiary = beneficiary;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    )),
                    CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        bgColor: Pallets.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        onPressed: selectedBeneficiary != null
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  CustomDialogs.showConfirmDialog(
                                    context,
                                    message:
                                        'You are about to withdrawal ${_amountController.text.removeCommas().formatAmount(symbol: "\$")} to ${selectedBeneficiary?.accountName}',
                                    onYes: () {
                                      context.pop();
                                      _bloc.add(RequestWithdrawalEvent(
                                          amount: double.parse(
                                              _amountController.text),
                                          beneficiaryId:
                                              selectedBeneficiary!.id!));
                                    },
                                  );
                                }
                              }
                            : null,
                        child: const TextView(
                          text: "Confirm Withdrawal",
                        )),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _listenToWalletBloc(BuildContext context, WalletState state) {
    if (state is RequestWithdrawLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is RequestWithdrawSuccessState) {
      context.pop();
      context.pop();
      injector.get<ProfileBloc>().add(GetProfileEvent());
      injector.get<WalletBloc>().add(GetWalletDetailsEvent());
      CustomDialogs.success('Withdrawal request sent');
    }

    if (state is RequestWithdrawFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
