import 'package:dap_game/common/widgets/custom_appbar.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/features/settings/data/repository/settings_repository_impl.dart';
import 'package:dap_game/features/settings/presentations/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final bloc = SettingsBloc(SettingsRepositoryImpl(injector.get()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(tittleText: "Send us a message."),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        bloc: bloc,
        listener: _listenToSettingsBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const TextView(
                    text:
                        "Having trouble? We understand. Send us a message and  let us know how we can assist you",
                    fontSize: 16,
                  ),
                  20.verticalSpace,
                  FilledTextField(
                    hint: "Message subject",
                    controller: _subjectController,
                  ),
                  20.verticalSpace,
                  FilledTextField(
                    hint: "Send a message..",
                    maxLine: 5,
                    controller: _messageController,
                  ),
                  20.verticalSpace,
                  CustomButton(
                    padding: const EdgeInsets.all(16),
                    child: const TextView(text: "Submit"),
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        bloc.add(ContactSupportEvent(
                            _subjectController.text, _messageController.text));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _listenToSettingsBloc(BuildContext context, SettingsState state) {
    if (state is ContactSupportLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ContactSupportFailedState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is ContactSupportSuccessState) {

      context.pop();
      context.pop();
      CustomDialogs.success("Message sent, We will send a reply via Email");

    }
  }
}
