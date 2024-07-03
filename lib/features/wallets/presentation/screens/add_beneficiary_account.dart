import 'package:country_picker/country_picker.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_payload.dart';
import 'package:dap_game/features/wallets/data/models/fetch_bank_response.dart';
import 'package:dap_game/features/wallets/data/repository/beneficiary_repository_impl.dart';
import 'package:dap_game/features/wallets/presentation/bloc/bank/bank_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/beneficiary/beneficiary_bloc.dart';
import 'package:dap_game/features/wallets/presentation/widgets/bank_list_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final nameController = TextEditingController();
  final beneficiaryBloc =
      BeneficiaryBloc(BeneficiaryRepositoryImpl(NetworkService()));
  bool accountVerified = false;
  BankData? _selectedBank;

  var _selectedCountry = Country.parse("NG");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BeneficiaryBloc, BeneficiaryState>(
      bloc: beneficiaryBloc,
      listener: _listenToBeneficiaryBloc,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
              color: Pallets.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                const TextView(
                  text: "Bank Country",
                  color: Pallets.darkblue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (value) {
                        _selectedCountry = value;
                        setState(() {});
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: _selectedCountry.name,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                const TextView(
                  text: "Bank Name",
                  color: Pallets.darkblue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    _selectBank(context, _selectedCountry.countryCode);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: _selectedBank?.name ?? "Bank",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        const Icon(Icons.keyboard_arrow_down_outlined),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                const TextView(
                  text: "Account Number",
                  color: Pallets.darkblue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                FilledTextField(
                  hint: "222222222222",
                  controller: accountController,
                  inputType: TextInputType.number,
                  onChanged: (p0) {
                    if (accountController.text.length == 10 &&
                        _selectedBank != null) {
                      injector.get<BankBloc>().add(VerifyBankEvent(
                          accountController.text, _selectedBank!.code!));
                    }
                    return p0;
                  },
                ),
                10.verticalSpace,
                BlocConsumer<BankBloc, BankState>(
                  listener: _listenToBankBloc,
                  bloc: injector.get(),
                  buildWhen: _buildWhen,
                  builder: (context, state) {
                    if (state is VerifyBankSuccessState && accountVerified) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextView(
                            text: "Account Name",
                            color: Pallets.darkblue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          10.verticalSpace,
                          FilledTextField(
                            hint: "Diala Victor",
                            controller: nameController,
                            enabled: false,
                          ),
                        ],
                      );
                    }

                    if (state is VerifyBankLoadingState) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomDialogs.getLoading(size: 20),
                      );
                    }

                    return 0.verticalSpace;
                  },
                ),
                20.verticalSpace,
                CustomButton(
                    borderRadius: BorderRadius.circular(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    onPressed: accountVerified
                        ? () {
                            addBeneficiary();
                          }
                        : null,
                    child: const TextView(
                      text: "Add beneficiary",
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  void addBeneficiary() {
    if (_formKey.currentState!.validate()) {
      beneficiaryBloc.add(AddBeneficiaryEvent(AddBeneficiaryPaylod(
        accountName: nameController.text,
        accountNo: accountController.text,
        bankCode: _selectedBank!.code,
        bankName: _selectedBank!.name,
        countryCode: 'NG',
      )));
    }
  }

  void _selectBank(BuildContext context, String countryCode) async {
    _selectedBank = await CustomDialogs.showBottomSheet(
        context,
        BankListSheet(
          countryCode: countryCode,
        ));

    if (accountController.text.length == 10 && _selectedBank != null) {
      injector
          .get<BankBloc>()
          .add(VerifyBankEvent(accountController.text, _selectedBank!.code!));
    }
    setState(() {});
  }

  void _listenToBankBloc(BuildContext context, BankState bankState) {
    if (bankState is VerifyBankSuccessState) {
      accountVerified = true;
      nameController.text = bankState.response.data.accountName;
      setState(() {});
    }

    if (bankState is VerifyBankFailureState) {
      accountVerified = false;
      CustomDialogs.error(bankState.error);
    }
  }

  bool _buildWhen(BankState previous, BankState current) {
    return current is VerifyBankLoadingState ||
        current is VerifyBankSuccessState ||
        current is VerifyBankFailureState;
  }

  void _listenToBeneficiaryBloc(BuildContext context, BeneficiaryState state) {
    if (state is BeneficairyLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is BeneficiarySuccessState) {
      context.pop();
      context.pop();

      injector.get<BeneficiaryBloc>().add(FetchBeneficiaryEvent());
      CustomDialogs.success('Beneficiary Added');
    }

    if (state is BeneficiaryFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
