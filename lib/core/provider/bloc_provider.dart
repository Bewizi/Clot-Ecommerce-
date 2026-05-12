import 'package:clot/features/auth/data/auth_data.dart';
import 'package:clot/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:clot/features/cart/data/cart_data.dart';
import 'package:clot/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:clot/features/home/data/categories_data.dart';
import 'package:clot/features/home/presentation/bloc/categories_bloc.dart';
import 'package:clot/features/products/bloc/products_bloc.dart';
import 'package:clot/features/products/data/products_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<BlocProvider> appBlocProvider = [
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(AuthData()),
  ),
  BlocProvider<CategoriesBloc>(
    create: (context) =>
        CategoriesBloc(categoriesRepository: CategoriesDataImpl()),
  ),
  BlocProvider<ProductsBloc>(
    create: (context) => ProductsBloc(productsRepository: ProductsDataImpl()),
  ),
  BlocProvider<CartBloc>(
    create: (context) => CartBloc(cartRepository: CartDataImpl()),
  ),
];
