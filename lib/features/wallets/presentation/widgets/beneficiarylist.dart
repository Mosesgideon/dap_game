import 'dart:developer';
import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/error_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/wallets/data/models/beneficiary_response.dart';
import 'package:dap_game/features/wallets/data/repository/beneficiary_repository_impl.dart';
import 'package:dap_game/features/wallets/presentation/bloc/beneficiary/beneficiary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BeneficiaryList extends StatefulWidget {
  const BeneficiaryList({
    super.key,
    required this.onBeneficiarySelected,
  });

  final Function(Beneficary beneficiary) onBeneficiarySelected;

  @override
  State<BeneficiaryList> createState() => _BeneficiaryListState();
}

class _BeneficiaryListState extends State<BeneficiaryList> {
  // final beneficiaryBloc =
  //     BeneficiaryBloc(BeneficiaryRepositoryImpl(NetworkService()));
  bool check = false;
  String selectedId = '';

  @override
  void initState() {
    injector.get<BeneficiaryBloc>().add(FetchBeneficiaryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      child: BlocConsumer<BeneficiaryBloc, BeneficiaryState>(
        listener: _listenToBeneficiaryState,
        bloc: injector.get<BeneficiaryBloc>(),
        builder: (context, state) {
          if (state is FetchBeneficairyLoadingState) {
            log("loading");
            return SizedBox(
              height: 100.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  30.verticalSpace,
                  CustomDialogs.getLoading(size: 30),
                ],
              ),
            );
          }
          if (state is FetchBeneficiaryFailureState) {
            return Center(
              child: AppPromptWidget(
                onTap: () {},
              ),
            );
          }
          if (state is FetchBeneficiarySuccessState) {
            log("success");
            log(state.response.success.toString());
            return ListView.builder(
              itemCount: state.response.data?.beneficaries?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                bool checked = selectedId ==
                    state.response.data!.beneficaries![index].id.toString();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: InkWell(
                    onTap: () {
                      selectedId = state.response.data!.beneficaries![index].id
                          .toString();
                      setState(() {});
                      widget.onBeneficiarySelected(
                          state.response.data!.beneficaries![index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Pallets.white,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                                color: Pallets.grey90)
                          ],
                          border: checked
                              ? Border.all(color: Pallets.primary)
                              : null),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Iconsax.bank,
                                size: 20,
                              ),
                              15.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                    text: state.response.data!
                                        .beneficaries![index].bankName
                                        .toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Pallets.primary,
                                  ),
                                  TextView(
                                    text: state.response.data!
                                        .beneficaries![index].accountNo
                                        .toString(),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Pallets.grey75,
                                  )
                                ],
                              ),
                            ],
                          ),
                          CustomCheckBox(
                              onChecked: (val) {
                                selectedId = state
                                    .response.data!.beneficaries![index].id
                                    .toString();
                                setState(() {});
                                widget.onBeneficiarySelected(
                                    state.response.data!.beneficaries![index]);
                              },
                              value: checked)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _listenToBeneficiaryState(BuildContext context, BeneficiaryState state) {
    if (state is BeneficairyLoadingState) {
      log("loading");

      CustomDialogs.getLoading(size: 30);
    }
    if (state is BeneficiaryFailureState) {
      log(state.error);
      AppPromptWidget(
        onTap: () {},
      );
    }
    if (state is BeneficiarySuccessState) {
      log("success");
    }
    if (state is FetchBeneficiarySuccessState) {}
  }
}
