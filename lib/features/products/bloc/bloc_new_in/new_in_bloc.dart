import 'package:bloc/bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:equatable/equatable.dart';

part 'new_in_event.dart';
part 'new_in_state.dart';

class NewInBloc extends Bloc<NewInEvent, NewInState> {
  NewInBloc({required this.productsRepository}) : super(NewInInitial()) {
    on<FetchNewIn>(_onFetchNewIn);
  }

  final ProductsRepository productsRepository;

  Future<void> _onFetchNewIn(FetchNewIn event, Emitter<NewInState> emit) async {
    emit(NewInLoading());
    try {
      final products = await productsRepository.getNewInProducts();
      emit(NewInLoaded(products: products));
    } on Exception catch (e) {
      emit(NewInError(message: e.toString()));
    }
  }
}
