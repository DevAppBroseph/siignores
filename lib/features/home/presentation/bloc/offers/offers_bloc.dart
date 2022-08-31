import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/offer_entity.dart';
import '../../../domain/usecases/get_offers.dart';
part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final GetOffers getOffers; 
  
  OffersBloc(this.getOffers) : super(OffersInitialState());

  List<OfferEntity> offers = [];
  @override
  Stream<OffersState> mapEventToState(OffersEvent event) async*{
    if(event is GetOffersEvent){
      yield OffersLoadingState();
      var offer = await getOffers(NoParams());

      yield offer.fold(
        (failure) => errorCheck(failure),
        (data){
          offers = data;
          return GotSuccessOffersState();
        }
      );
    }


    
  }


  OffersState errorCheck(Failure failure){
    print('FAIL: ${failure}');
    if(failure == ConnectionFailure() || failure == NetworkFailure()){
      return OffersInternetErrorState();
    }else if(failure is ServerFailure){
      return OffersErrorState(message: failure.message.length < 100 ? failure.message : 'Ошибка сервера');
    }else{
      return OffersErrorState(message: 'Повторите попытку');
    }
  }

}
