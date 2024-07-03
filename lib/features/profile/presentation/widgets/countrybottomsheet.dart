import 'package:dap_game/common/widgets/custom_checkbox.dart';
import 'package:dap_game/common/widgets/custom_dialogs.dart';
import 'package:dap_game/common/widgets/custom_outlined_button.dart';
import 'package:dap_game/common/widgets/filled_textfield.dart';
import 'package:dap_game/common/widgets/text_view.dart';
import 'package:dap_game/core/constants/package_exports.dart';
import 'package:dap_game/core/services/network/network_service.dart';
import 'package:dap_game/core/theme/pallets.dart';
import 'package:dap_game/features/profile/data/repository/account_repository_impl.dart';
import 'package:dap_game/features/profile/presentation/bloc/fetc_country/fetchcounty_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCountryBottomSheet extends StatefulWidget {
  final Function(String) onCountrySelected;

  const SelectCountryBottomSheet({super.key, required this.onCountrySelected});

  @override
  State<SelectCountryBottomSheet> createState() =>
      _SelectCountryBottomSheetState();
}

class _SelectCountryBottomSheetState extends State<SelectCountryBottomSheet> {
  final fetchCountriesBloc =
      FetchcountyBloc(AccountRepositoryImpl(NetworkService()));

  String selectedCountry = "";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchCountriesBloc.add(CountryFectchedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Pallets.mildBlue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextView(
              text: "Select your country",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Pallets.darkblue,
            ),
          ),
          15.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              child: FilledTextField(
                fillColor: Pallets.midblue,
                hint: "Search country",
                onChanged: (value) {
                  setState(() {
                    searchQuery = value!;
                  });
                },
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
            child: BlocConsumer<FetchcountyBloc, FetchcountyState>(
              bloc: fetchCountriesBloc,
              listener: (context, state) {
                if (state is FetchCountryFailureState) {
                  CustomDialogs.error(state.error);
                }
              },
              builder: (context, state) {
                if (state is FetchCountryLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchCountrySuccessState) {
                  final countries = state.response.data?.countries
                      ?.where((country) =>
                          country.name
                              ?.toLowerCase()
                              .contains(searchQuery.toLowerCase()) ??
                          true)
                      .toList();
                  return ListView.builder(
                    itemCount: countries?.length ?? 0,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      String? countryName = countries?[index].name;
                      bool isSelected = selectedCountry == countryName;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCountry = countryName ?? "";
                          });
                          widget.onCountrySelected(selectedCountry);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              CustomCheckBox(
                                onChecked: (bool val) {},
                                checkedColor: isSelected
                                    ? Pallets.darkblue
                                    : Pallets.grey,
                                value: isSelected,
                              ),
                              Expanded(
                                child: TextView(
                                  text: countryName ?? '',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Pallets.darkblue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FetchCountryFailureState) {
                  return Center(
                    child: Center(
                      child: CustomOutlinedButton(
                        radius: 20,
                        isExpanded: false,
                        onPressed: () {},
                        child: const TextView(
                          text: "error occured",
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }

  void _listentToFetchCountryState(
      BuildContext context, FetchcountyState state) {
    if (state is FetchCountryLoadingState) {
      CustomDialogs.showLoading(context);
    } else if (state is FetchCountrySuccessState) {
      Navigator.pop(context);
    } else if (state is FetchCountryFailureState) {
      CustomDialogs.error(state.error);
    }
  }
}
//
// class SeletCityBottomSheet extends StatefulWidget {
//   final Function(String) onCitySelected;
//   const SeletCityBottomSheet({super.key, required this.onCitySelected});
//
//   @override
//   State<SeletCityBottomSheet> createState() => _SeletCityBottomSheetState();
// }
//
// class _SeletCityBottomSheetState extends State<SeletCityBottomSheet> {
//
//   final fetchCitiesBloc =
//   FetchcountyBloc(AccountRepositoryImpl(NetworkService()));
//
//   String selectedCity = "";
//   String searchQuery = "";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCitiesBloc.add(CountryFectchedEvent());
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.6,
//       ),
//       padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//         color: Pallets.mildBlue,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: TextView(
//               text: "Select your country",
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Pallets.darkblue,
//             ),
//           ),
//           15.verticalSpace,
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: SizedBox(
//               height: 50,
//               child: FilledTextField(
//                 fillColor: Pallets.midblue,
//                 hint: "Search country",
//                 onChanged: (value) {
//                   setState(() {
//                     searchQuery = value!;
//                   });
//                 },
//               ),
//             ),
//           ),
//           10.verticalSpace,
//           Expanded(
//             child: BlocConsumer<FetchcountyBloc, FetchcountyState>(
//               bloc: fetchCitiesBloc,
//               listener: (context, state) {
//                 if (state is FetchCountryFailureState) {
//                   CustomDialogs.error(state.error);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is FetchCountryLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is FetchCountrySuccessState) {
//                   final city = state.response.data!.countries![index].capital
//                       ?.where((country) =>
//                   country.name
//                       ?.toLowerCase()
//                       .contains(searchQuery.toLowerCase()) ??
//                       true)
//                       .toList();
//                   return ListView.builder(
//                     itemCount: city?.length ?? 0,
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       String? cityName = city?[index].name;
//                       bool isSelected = selectedCity == cityName;
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedCity = cityName ?? "";
//                           });
//                           widget.onCitySelected(selectedCity);
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           child: Row(
//                             children: [
//                               CustomCheckBox(
//                                 onChecked: (bool val) {},
//                                 checkedColor: isSelected
//                                     ? Pallets.darkblue
//                                     : Pallets.grey,
//                                 value: isSelected,
//                               ),
//                               Expanded(
//                                 child: TextView(
//                                   text: cityName ?? '',
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 15,
//                                   color: Pallets.darkblue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is FetchCountryFailureState) {
//                   return Center(
//                     child: Center(
//                       child: CustomOutlinedButton(
//                         radius: 20,
//                         isExpanded: false,
//                         onPressed: () {},
//                         child: const TextView(
//                           text: "error occured",
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//                 return SizedBox();
//               },
//             ),
//           ),
//           10.verticalSpace,
//         ],
//       ),
//     );
//   }
//
//
//   void _listentToFetchCityState(
//       BuildContext context, FetchcountyState state) {
//     if (state is FetchCountryLoadingState) {
//       CustomDialogs.showLoading(context);
//     } else if (state is FetchCountrySuccessState) {
//       Navigator.pop(context);
//     } else if (state is FetchCountryFailureState) {
//       CustomDialogs.error(state.error);
//     }
//   }
// }
