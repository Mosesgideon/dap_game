part of '../../bloc/beneficiary/beneficiary_bloc.dart';

abstract class BeneficiaryState extends Equatable {}

class BeneficiaryInitial extends BeneficiaryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BeneficairyLoadingState extends BeneficiaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BeneficiarySuccessState extends BeneficiaryState {
  final BeneficiaryResponse response;

  BeneficiarySuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class BeneficiaryFailureState extends BeneficiaryState {
  final String error;

  BeneficiaryFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class FetchBeneficairyLoadingState extends BeneficiaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchBeneficiarySuccessState extends BeneficiaryState {
  final BeneficiaryResponse response;

  FetchBeneficiarySuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class FetchBeneficiaryFailureState extends BeneficiaryState {
  final String error;

  FetchBeneficiaryFailureState(this.error);

  @override
  List<Object?> get props => [error];
}
