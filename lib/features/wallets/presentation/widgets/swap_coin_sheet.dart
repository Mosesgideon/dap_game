import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

enum SwapOption { Coin, Cash }

class SwapCoinSheet extends StatefulWidget {
  const SwapCoinSheet({super.key});

  @override
  State<SwapCoinSheet> createState() => _SwapCoinSheetState();
}

class _SwapCoinSheetState extends State<SwapCoinSheet> {
  SwapOption _fromOption = SwapOption.Coin;
  SwapOption _toOption = SwapOption.Cash;
  String _amount = "";
  final double _exchangeRate = double.parse(
      injector.get<UserBloc>().appUser?.coinWallet.rate ??
          "0"); // Placeholder exchange rate, adjust as needed

  final bloc = WalletBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      bloc: bloc,
      listener: _listenToWalletBloc,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ImageWidget(imageUrl: Assets.images.pngs.coin.path),
                    5.horizontalSpace,
                    TextView(
                      text: "Swap Coin",
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Pallets.primary,
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                SwapOptionDropdown(
                    label: "From",
                    initialValue: _fromOption,
                    onChanged: (option) =>
                        setState(() => _fromOption = option!)),
                16.verticalSpace,
                SwapOptionDropdown(
                    label: "To",
                    initialValue: _toOption,
                    onChanged: (option) => setState(() => _toOption = option!)),
                16.verticalSpace,
                AmountInput(onChanged: (value) {
                  setState(() => _amount = value ?? "0");
                }),
                const SizedBox(height: 8.0),
                EquivalentText(
                    amount: _amount,
                    fromOption: _fromOption,
                    toOption: _toOption,
                    exchangeRate: _exchangeRate),
                10.verticalSpace,
                CustomButton(
                  padding: const EdgeInsets.all(16),
                  child: const TextView(text: "Swap"),
                  onPressed: () {
                    if (_amount.isNotEmpty) {
                      bloc.add(SwapCoinEvent(
                          amount: double.parse(_amount),
                          swapType: _toOption == SwapOption.Coin
                              ? "to_coin"
                              : "from_coin"));
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _listenToWalletBloc(BuildContext context, WalletState state) {
    if (state is SwapCoinLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is SwapCoinFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is SwapCoinSuccessState) {
      context.pop();
      context.pop();
      injector.get<ProfileBloc>().add(GetProfileEvent());
      injector.get<WalletBloc>().add(GetWalletDetailsEvent());
      CustomDialogs.success("Swapped Successfully");
    }
  }
}

class SwapOptionDropdown extends StatelessWidget {
  final String label;
  final SwapOption initialValue;
  final Function(SwapOption?) onChanged;

  SwapOptionDropdown({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: label,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        8.verticalSpace,
        ButtonTheme(
          alignedDropdown: true,
          layoutBehavior: ButtonBarLayoutBehavior.constrained,
          child: DropdownButtonFormField<SwapOption>(
            // Use DropdownButtonFormField for outline and hint
            value: initialValue,

            isExpanded: false,

            hint: Text(
              "Select", // Hint text
              style: Theme.of(context).textTheme.caption,
            ),
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), // Radius
                borderSide: const BorderSide(color: Pallets.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), //
                // Radius
                borderSide: const BorderSide(color: Pallets.grey),
              ),
            ),
            items: SwapOption.values
                .map((option) => DropdownMenuItem<SwapOption>(
                      value: option,
                      child: Row(
                        children: [
                          ImageWidget(
                              imageUrl: option == SwapOption.Cash
                                  ? Assets.images.svgs.dollar
                                  : Assets.images.pngs.coin.path),
                          8.horizontalSpace,
                          Text("${option.name} balance"),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class AmountInput extends StatelessWidget {
  final String? Function(String?) onChanged;

  const AmountInput({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        const TextView(text: "Enter Amount"),
        4.verticalSpace,
        FilledTextField(
          inputType: TextInputType.number,
          onChanged: onChanged,
          hint: 'Enter Amount',
          fillColor: Colors.transparent,
        ),
      ],
    );
  }
}

class EquivalentText extends StatelessWidget {
  final String amount;
  final SwapOption fromOption;
  final SwapOption toOption;
  final double exchangeRate;

  const EquivalentText({
    Key? key,
    required this.amount,
    required this.fromOption,
    required this.toOption,
    required this.exchangeRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      amount.isEmpty
          ? ""
          : (fromOption == SwapOption.Coin && toOption == SwapOption.Cash)
              ? "You will get : ${double.parse(amount) / exchangeRate} in ${toOption.name}"
              : (fromOption == SwapOption.Cash && toOption == SwapOption.Coin)
                  ? "You will get : ${double.parse(amount) * exchangeRate} in ${toOption.name}"
                  : "Invalid swap combination",
      style: GoogleFonts.sora(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
