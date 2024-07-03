import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'amount_picker_widget.dart';

class AmountSheet extends StatefulWidget {
  const AmountSheet({Key? key}) : super(key: key);

  @override
  State<AmountSheet> createState() => _AmountSheetState();
}

class _AmountSheetState extends State<AmountSheet> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormFieldState>();

  // final bloc = injector.get<WalletBloc>();
  // final paymentBloc = PaymentCubit(injector.get());

  @override
  Widget build(BuildContext context) {
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
              'Enter Amount',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            AmountPickerWidget(
              onSelected: (String value) {
                _amountController.text = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            FilledTextField(
              formKey: _formKey,
              hint: 'Amount',
              inputType: TextInputType.number,
              controller: _amountController,
              validator: RequiredValidator(errorText: 'Enter amount').call,
              // preffix: Icon(
              //   FluentIcons.send_20_regular,
              //   color: Theme.of(context).colorScheme.onBackground,
              // ),
              fillColor: Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                padding: const EdgeInsets.all(18),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context.pop(int.parse(_amountController.text));
                  }
                },
                child: const Text('Continue'))
          ],
        ),
      ),
    );
  }
}

// bool isLoading(PaymentState state) => state.status == PaymentStatus.loading;
