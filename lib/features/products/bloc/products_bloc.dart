import 'package:bloc/bloc.dart';
import 'package:clot/features/products/domain/products_domain.dart';
import 'package:clot/features/products/domain/products_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.productsRepository}) : super(ProductsInitial()) {
    on<GetProducts>(_onGetProducts);
    on<AllProducts>(_onAllProducts);
    on<GetTopSelling>(_onGetTopSelling);
    on<GetNewIn>(_onGetNewIn);
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

  Future<void> _onAllProducts(
    AllProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await productsRepository.getAllProducts();
      emit(ProductsLoaded(products: products));
    } on Exception catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> _onGetTopSelling(
    GetTopSelling event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await productsRepository.getTopSellingProducts();
      emit(TopSellingLoaded(products: products));
    } on Exception catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> _onGetNewIn(
    GetNewIn event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final products = await productsRepository.getNewInProducts();
      emit(NewInLoaded(products: products));
    } on Exception catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}
