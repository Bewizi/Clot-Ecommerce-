import 'package:bloc/bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.productsRepository}) : super(ProductsInitial()) {
    on<GetProducts>(_onGetProducts);
  }

  final ProductsRepository productsRepository;

  Future<void> _onGetProducts(
    GetProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await productsRepository.getProductsByCategoryId(
        event.categoryId,
      );
      emit(ProductsLoaded(products: products));
    } on Exception catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}
