part of 'offers_bloc.dart';

class OffersState extends Equatable {
  const OffersState();
  @override
  List<Object> get props => [];
}

class OffersInitialState extends OffersState {}
class OffersLoadingState extends OffersState {}
class OffersErrorState extends OffersState {
  final String message;
  OffersErrorState({required this.message});
}
class OffersInternetErrorState extends OffersState{}

class GotSuccessOffersState extends OffersState{}
