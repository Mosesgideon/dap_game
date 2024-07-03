// ignore_for_file: unnecessary_null_comparison
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/url_config.dart';
import 'package:dap_game/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class FlutterRequirements {
  final num? amount;
  final String? currency;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final String? referenceNumber;

  FlutterRequirements(
      {required this.amount,
      required this.referenceNumber,
      this.email,
      this.currency,
      this.fullName,
      this.phoneNumber});
}

class PaymentHelper {
  Future<String?> makePayment(
      BuildContext context, FlutterRequirements requirements,
      {Function(ChargeResponse)? response}) async {
    try {
      // logger.i("PAYMENT ID${requirements.planId}");
      // logger.i("Key ${AppConfig.flutterWavePublicKey}");
      // final style = FlutterwaveStyle(
      //   appBarText: "Medbury",
      //   buttonColor: Pallets.red,
      //   buttonTextStyle: TextStyle(
      //     color: Pallets.white,
      //     fontSize: 16,
      //   ),
      //   appBarColor: Pallets.red,
      //   dialogCancelTextStyle: const TextStyle(
      //     color: Pallets.grey,
      //     fontSize: 18,
      //   ),
      //   dialogContinueTextStyle: TextStyle(
      //     color: Pallets.red,
      //     fontSize: 16,
      //   ),
      //   mainBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   mainTextStyle: const TextStyle(fontSize: 19, letterSpacing: 2),
      //   dialogBackgroundColor: Theme.of(context).cardColor,
      //   appBarIcon: const Icon(Icons.clear, color: Pallets.white),
      //   buttonText:
      //   "Pay ${Helpers.currencySymbol(context, requirements.amount ?? 0)}",
      //   appBarTitleTextStyle: TextStyle(
      //     color: Pallets.white,
      //     fontSize: 16,
      //   ),
      // );

      final Customer _customer = Customer(
          name: requirements.fullName!,
          phoneNumber: requirements.phoneNumber!,
          email: requirements.email!);

      final _flutterwave = Flutterwave(
        // style: style,

        context: context,
        publicKey: UrlConfig.flutterWavePublicKey,
        currency: 'USD',
        txRef: requirements.referenceNumber!,
        amount: requirements.amount!.toString(),
        customer: _customer,
        paymentOptions: 'card',
        meta: {
          "payment_details": {"mode": "card", "type": "funding"}
        },
        // paymentPlanId: requirements.planId,
        customization: Customization(
            title: "Wallet funding", logo: Assets.images.pngs.launcher.path),
        isTestMode: false,
        redirectUrl: 'https://api.dapgames.com/api/payments/webhook-event',
      );
      final _response = await _flutterwave.charge();
      if (_response != null) {
        // response!(_response);
        if (_response.success ?? false) {
          logger.w(_response.toJson());

          return _response.transactionId.toString();
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      logger.e(error);
      return null;
    }
  }
}
