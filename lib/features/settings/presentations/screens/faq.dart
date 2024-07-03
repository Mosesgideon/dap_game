import 'dart:developer';

import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/settings/data/repository/faq_repo_impl.dart';
import 'package:dap_game/features/settings/presentations/bloc/faq/faq_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQ_Screen extends StatefulWidget {
  const FAQ_Screen({super.key});

  @override
  State<FAQ_Screen> createState() => _FAQ_ScreenState();
}

class _FAQ_ScreenState extends State<FAQ_Screen> {
  // final faqBloc = FaqBloc(injector.get());
  final faqBloc = FaqBloc(FaqRepositoryImpl(NetworkService()));
  bool isclicked = false;

  @override
  void initState() {
    faqBloc.add(FaqFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        tittle: TextView(
          text: "Faq",
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocConsumer<FaqBloc, FaqState>(
        listener: _listenToFaqState,
        bloc: faqBloc,
        builder: (context, state) {
          if (state is FaqLoadingState) {
            return Center(
              child: CustomDialogs.getLoading(size: 40),
            );
          }
          if (state is FaqFetchedState) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.response.data!.faqs!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Pallets.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Pallets.grey90,
                                  spreadRadius: 0.5,
                                  blurRadius: 1),
                            ]),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Pallets.midblue,
                          title: TextView(
                            text: state.response.data!.faqs![index].question
                                .toString(),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(isclicked
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 5),
                              child: TextView(
                                text: state.response.data!.faqs![index].answer
                                    .toString(),
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            10.verticalSpace,
                          ],
                          onExpansionChanged: (bool isChanged) {
                            setState(() {
                              isclicked = isChanged;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ));
          }
          if (state is FaqFetchFailureState) {
            return Center(
              child: CustomDialogs.error("Oops,try again"),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  void _listenToFaqState(BuildContext context, FaqState state) {
    if (state is FaqLoadingState) {
      print("loading");
      log("loading");
    }
    if (state is FaqFetchedState) {
      log("fetched");
    }
    if (state is FaqFetchFailureState) {
      CustomDialogs.error("Failed");
    }
  }
}
