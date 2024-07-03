part of 'faq_bloc.dart';

@immutable
abstract class FaqEvent extends Equatable {}

class FaqFetchedEvent extends FaqEvent {
  @override
  List<Object?> get props => [];
}
