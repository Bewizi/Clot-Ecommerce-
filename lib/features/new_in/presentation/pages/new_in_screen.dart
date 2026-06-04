import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/product_card.dart';
import 'package:clot/features/products/bloc/bloc_new_in/new_in_bloc.dart';
import 'package:clot/features/products/data/products_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInScreen extends StatefulWidget {
  const NewInScreen({super.key});

  @override
  State<NewInScreen> createState() => _NewInScreenState();
}

class _NewInScreenState extends State<NewInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewInBloc(
        productsRepository: ProductsDataImpl(),
      )..add(const FetchNewIn()),
      child: AppScaffold(
        appbar: AppBar(
          leading: const AppBackButton(),
          forceMaterialTransparency: true,
          title: AppText(
            'New In',
            style: context.textTheme.headlineLarge,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<NewInBloc, NewInState>(
                builder: (context, state) {
                  if (state is NewInLoading) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is NewInError) {
                    return SizedBox(
                      height: 100,
                      child: Center(child: AppText(state.message)),
                    );
                  }

                  if (state is NewInLoaded) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: product,
                        );
                      },
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
