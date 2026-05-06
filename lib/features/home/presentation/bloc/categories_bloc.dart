import 'package:bloc/bloc.dart';
import 'package:clot/features/home/domain/categories_domain.dart';
import 'package:clot/features/home/domain/categories_repository.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.categoriesRepository})
    : super(CategoriesInitial()) {
    on<GetCategories>(_onGetCategories);
  }
  final CategoriesRepository categoriesRepository;

  Future<void> _onGetCategories(
    GetCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    try {
      final categories = await categoriesRepository.getCategories();
      emit(CategoriesLoaded(categories: categories));
    } on Exception catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }
}
