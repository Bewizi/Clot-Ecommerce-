part of 'top_selling_bloc.dart';

sealed class TopSellingEvent extends Equatable {
  const TopSellingEvent();

  @override
  List<Object> get props => [];
}

class FetchTopSelling extends TopSellingEvent {
  const FetchTopSelling();
}
