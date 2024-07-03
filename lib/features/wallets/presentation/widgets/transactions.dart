import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/data/models/wallet_details_response.dart';
import 'package:dap_game/features/wallets/presentation/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  void initState() {
    injector.get<WalletBloc>().add(GetWalletDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: _listenToWalletState,
      bloc: injector.get<WalletBloc>(),
      builder: (context, state) {
        if (state is GetWalletLoadingState) {
          return Center(
            child: CustomDialogs.getLoading(size: 30),
          );
        }
        if (state is GetWalletSuccessState) {
          if (state.response.data.transactions.isEmpty) {
            return AppPromptWidget(
              message: "You currently have no transactions yet",
              title: 'No transactions',
              onTap: () {
                injector.get<WalletBloc>().add(GetWalletDetailsEvent());
              },
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.response.data.transactions.length,
            itemBuilder: (BuildContext context, int index) => _TransactionItem(
                transaction: state.response.data.transactions[index]),
          );
        }
        if (state is GetWalletFailureState) {
          return AppPromptWidget(
            message: state.error,
            title: 'Oops!',
            onTap: () {
              injector.get<WalletBloc>().add(GetWalletDetailsEvent());
            },
          );
        }
        return 0.verticalSpace;
      },
    );
  }

  void _listenToWalletState(BuildContext context, WalletState state) {
    //
    // if(){
    //
    // }
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({super.key, required this.transaction});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Pallets.grey90.withOpacity(0.2)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Pallets.white,
              child: _getTransactionIcon(transaction.type),
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: transaction.channel.toString().toUpperCase(),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Pallets.primary,
                ),
                6.verticalSpace,
                TextView(
                  text: TimeUtil.formatDate(
                      transaction.updatedAt.toIso8601String()),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Pallets.grey75,
                ),
              ],
            ),
            const Spacer(),
            TextView(
              text: "\$${transaction.amount.formatAmount()}",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _getTransactionColor(transaction.type),
            )
          ],
        ),
      ),
    );
  }

  _getTransactionColor(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
        return Colors.green;
      case 'withdrawal':
        return Colors.red;
      default:
        break;
    }
  }

  _getTransactionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
        return Icon(
          Icons.arrow_downward_sharp,
          size: 20,
          color: _getTransactionColor(type),
        );
      case 'withdrawal':
        return Icon(
          Icons.arrow_upward_rounded,
          size: 20,
          color: _getTransactionColor(type),
        );
      default:
        break;
    }
  }
}
