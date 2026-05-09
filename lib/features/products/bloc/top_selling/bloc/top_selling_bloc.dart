import 'package:bloc/bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:equatable/equatable.dart';

part 'top_selling_event.dart';
part 'top_selling_state.dart';

class TopSellingBloc extends Bloc<TopSellingEvent, TopSellingState> {
  TopSellingBloc({required this.productsRepository})
    : super(TopSellingInitial()) {
    on<FetchTopSelling>(_onFetchTopSelling);
  }

  final ProductsRepository productsRepository;

  Future<void> _onFetchTopSelling(
    FetchTopSelling event,
    Emitter<TopSellingState> emit,
  ) async {
    emit(TopSellingLoading());
    try {
      final products = await productsRepository.getTopSellingProducts();
      emit(TopSellingLoaded(products: products));
    } on Exception catch (e) {
      emit(TopSellingFailure(errorMessage: e.toString()));
    }
  }
}
