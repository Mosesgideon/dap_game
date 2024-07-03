import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/features/wallets/presentation/widgets/amount_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CoinAmountSheet extends StatefulWidget {
  const CoinAmountSheet({Key? key}) : super(key: key);

  @override
  State<CoinAmountSheet> createState() => _CoinAmountSheetState();
}

class _CoinAmountSheetState extends State<CoinAmountSheet> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormFieldState>();
  final bloc = WalletBloc(injector.get());
  var rate =
      double.parse(injector.get<UserBloc>().appUser?.coinWallet.rate ?? "0");

  var cost = 0.0;

  // final bloc = injector.get<WalletBloc>();
  // final paymentBloc = PaymentCubit(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter Number Of Coin',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                AmountPickerWidget(
                  amounts: const [
                    '500',
                    '1000',
                    '2000',
                    "3000",
                    "4000",
                    "5000"
                  ],
                  onSelected: (String value) {
                    _amountController.text = value;
                    calculateCost();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                FilledTextField(
                  formKey: _formKey,
                  hint: '',
                  inputType: TextInputType.number,
                  controller: _amountController,
                  onChanged: (p0) {
                    calculateCost();
                  },
                  validator:
                      RequiredValidator(errorText: 'This field is required')
                          .call,
                  // preffix: Icon(
                  //   FluentIcons.send_20_regular,
                  //   color: Theme.of(context).colorScheme.onBackground,
                  // ),
                  fillColor: Colors.grey.withOpacity(0.2),
                ),
                TextView(
                  text: "This will cost you \$$cost",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Pallets.primary,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    padding: const EdgeInsets.all(18),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.pop(cost);
                      }
                    },
                    child: const Text('Continue'))
              ],
            ),
          ),
        );
      },
    );
  }

  void calculateCost() {
    var selectedAmount = double.parse(_amountController.text);
    cost = (selectedAmount / rate);
    setState(() {});
  }
}

// bool isLoading(PaymentState state) => state.status == PaymentStatus.loading;
