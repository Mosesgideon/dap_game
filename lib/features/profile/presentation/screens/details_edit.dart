import 'package:dap_game/common/widgets/circular_loader.dart';
import 'package:dap_game/common/widgets/custom_button.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/image_widget.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/_core.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/di/injector.dart';
import 'package:dap_game/core/navigation/route_url.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/data/repository/account_repository_impl.dart';
import 'package:dap_game/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:dap_game/features/profile/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dap_game/features/profile/presentation/widgets/countrybottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({
    super.key,
  });

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  XFile? profileFile;
  XFile? coverFile;
  final ImagePicker _picker = ImagePicker();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _statecontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final updateBloc = ProfileBloc(AccountRepositoryImpl(NetworkService()));
  String selectedCountry = "";
  String selectedCity = "";
  DateTime? dob;

  final _dobController = TextEditingController();

  @override
  void initState() {
    prefillData();
    super.initState();
  }

  void prefillData() {
    final userBloc = injector.get<UserBloc>();

    _firstnameController.text = userBloc.appUser?.firstname??'';
    _lastnameController.text = userBloc.appUser?.lastname??'';
    _usernameController.text = userBloc.appUser?.username??'';
    _countryController.text = userBloc.appUser?.country ?? '';
    _phoneController.text = userBloc.appUser?.phone ?? '';
    _statecontroller.text = userBloc.appUser?.state ?? '';
    _citycontroller.text = userBloc.appUser?.city ?? '';
    _dobController.text = userBloc.appUser?.dob != null
        ? TimeUtil.formatDate(userBloc.appUser?.dob)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    final profilebloc = ProfileBloc(injector.get());
    final userBloc = injector.get<UserBloc>();

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    Center(
                      child: SafeArea(
                        child: Stack(clipBehavior: Clip.none, children: [
                          profileFile != null
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Pallets.grey.withOpacity(0.4),
                                      border: Border.all(
                                          color: Pallets.darkblue, width: 2),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(profileFile!.path)))),
                                )
                              : ImageWidget(
                                  imageUrl: userBloc.appUser?.profilePhoto,
                                  borderRadius: BorderRadius.circular(50),
                                  size: 100,
                                  border: Border.all(
                                      color: Pallets.primary, width: 2),
                                ),
                          Positioned(
                              right: -4,
                              bottom: -6,
                              child: InkWell(
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Card(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Pallets.primary,
                                    ),
                                  ),
                                ),
                              ))
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            40.verticalSpace,
                            FilledTextField(
                              controller: _firstnameController,
                              hint: "First name",
                              hasElevation: false,
                              preffix: const Icon(Iconsax.profile_add),
                              fillColor: Pallets.white,
                            ),
                            20.verticalSpace,
                            FilledTextField(
                              controller: _lastnameController,
                              hint: "Last name",
                              hasElevation: false,
                              preffix: const Icon(Iconsax.profile_add),
                              fillColor: Pallets.white,
                            ),
                            20.verticalSpace,
                            FilledTextField(
                              controller: _usernameController,
                              hint: "username",
                              hasElevation: false,
                              preffix: const Icon(Iconsax.user),
                              fillColor: Pallets.white,
                            ),
                            20.verticalSpace,
                            FilledTextField(
                              controller: _phoneController,
                              hint: "07042973460",
                              hasElevation: false,
                              inputType: TextInputType.number,
                              preffix: const Icon(Iconsax.call),
                              fillColor: Pallets.white,
                            ),
                            20.verticalSpace,
                            InkWell(
                              onTap: () {
                                _selectDateOfBirth();
                              },
                              child: FilledTextField(
                                controller: _dobController,
                                hint: "Date of birth",
                                enabled: false,
                                hasElevation: false,
                                preffix: const Icon(Iconsax.calendar),
                                fillColor: Pallets.white,
                              ),
                            ),
                            20.verticalSpace,
                            InkWell(
                              onTap: () {
                                CustomDialogs.showBottomSheet(context,
                                    SelectCountryBottomSheet(
                                  onCountrySelected: (country) {
                                    setState(() {
                                      selectedCountry = country;
                                    });
                                  },
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 18),
                                decoration: BoxDecoration(
                                    color: Pallets.white,
                                    border: Border.all(color: Pallets.grey95),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.flag_outlined,
                                          color: Pallets.grey,
                                        ),
                                        10.horizontalSpace,
                                        TextView(
                                          text: selectedCountry.isEmpty
                                              ? userBloc.appUser?.country ??
                                                  'Select your country'
                                              : selectedCountry,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        )
                                      ],
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            // Container(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 15, vertical: 18),
                            //   decoration: BoxDecoration(
                            //       color: Pallets.white,
                            //       border: Border.all(color: Pallets.grey95),
                            //       borderRadius: BorderRadius.circular(10)),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           const Icon(
                            //             Icons.flag_outlined,
                            //             color: Pallets.grey,
                            //           ),
                            //           10.horizontalSpace,
                            //           TextView(
                            //             text: selectedCity.isEmpty
                            //                 ? userBloc.appUser?.city ?? 'Select your city'
                            //                 : selectedCity,
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.w400,
                            //             color:selectedCity.isEmpty? Pallets.grey:null,
                            //           )
                            //         ],
                            //       ),
                            //       InkWell(
                            //         onTap: () {
                            //           CustomDialogs.showBottomSheet(context,
                            //               SelectCountryBottomSheet(
                            //             onCountrySelected: (country ) {
                            //               setState(() {
                            //                 selectedCountry = country;
                            //               });
                            //             },
                            //           ));
                            //         },
                            //         child: const Icon(
                            //           Icons.keyboard_arrow_down_rounded,
                            //           size: 25,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // 20.verticalSpace,
                          ]),
                    ),
                    50.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BlocConsumer<ProfileBloc, ProfileState>(
                        listener: _listenToUpdateProfileState,
                        bloc: updateBloc,
                        builder: (context, state) {
                          return CustomButton(
                            borderRadius: BorderRadius.circular(25),
                            bgColor: Pallets.orange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            onPressed: state is! ProfileLoadingState
                                ? () {
                                    updateProfile();
                                  }
                                : null,
                            child: (state is ProfileLoadingState)
                                ? const CircularLoader(
                                    size: 20,
                                  )
                                : const TextView(
                                    text: "Save Update",
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  void updateProfile() {
    if (_formKey.currentState!.validate()) {
      final files = profileFile;
      final coverImage = coverFile;
      updateBloc.add(ProfileUpdatedEvent(
          country: selectedCountry,
          phonNumber: _phoneController.text,
          lastname: _lastnameController.text,
          profileimage: files?.path,
          coverimage: coverImage?.path,
          firstname: _firstnameController.text,
          username: _usernameController.text,
          dob: dob?.toIso8601String()));
    }
  }

  Future<File?> _pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File myfile = File(image.path);
      File myCoverfile = File(image.path);
    }
    setState(() {
      profileFile = image;
      coverFile = image;
    });
    return null;
  }

  void _listenToUpdateProfileState(BuildContext context, ProfileState state) {
    if (state is ProfileLoadingState) {}
    if (state is ProfileUpdateSuccessState) {
      CustomDialogs.success("Profile Updated ");
      context.goNamed(PageUrl.home);
    }
    if (state is ProfileFailureState) {
      logger.e(state.error);
      CustomDialogs.error(state.error);
    }
  }

  void _selectDateOfBirth() async {
    var _dob = await showDatePicker(
        context: context,
        helpText: "Select date of birth",
        initialDate: DateTime.now().subtract(const Duration(days: 360 * 18)),
        firstDate: DateTime(1800),
        lastDate: DateTime.now().subtract(const Duration(days: 360 * 18)));

    if (_dob != null) {
      dob = _dob;
      _dobController.text = TimeUtil.formatDate(dob.toString());

      setState(() {});
    }
  }
}
