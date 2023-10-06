import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  AuctionBloc() : super(AuctionInitial()) {
    on<AuctionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
