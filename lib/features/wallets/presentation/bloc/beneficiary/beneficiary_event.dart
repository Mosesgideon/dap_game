part of '../../bloc/beneficiary/beneficiary_bloc.dart';

@immutable
abstract class BeneficiaryEvent extends Equatable{}

class AddBeneficiaryEvent extends BeneficiaryEvent {
  AddBeneficiaryPaylod paylod;
  AddBeneficiaryEvent(this.paylod);
  @override
  List<Object?> get props => [paylod];
}
class FetchBeneficiaryEvent extends BeneficiaryEvent {
  @override
  List<Object?> get props => [];
}
