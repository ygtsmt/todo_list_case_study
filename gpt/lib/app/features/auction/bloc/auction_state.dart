part of 'auction_bloc.dart';

sealed class AuctionState extends Equatable {
  const AuctionState();
  
  @override
  List<Object> get props => [];
}

final class AuctionInitial extends AuctionState {}
