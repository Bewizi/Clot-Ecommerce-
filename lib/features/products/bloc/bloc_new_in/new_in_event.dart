part of 'new_in_bloc.dart';

sealed class NewInEvent extends Equatable {
  const NewInEvent();

  @override
  List<Object> get props => [];
}

class FetchNewIn extends NewInEvent {
  const FetchNewIn();
}
