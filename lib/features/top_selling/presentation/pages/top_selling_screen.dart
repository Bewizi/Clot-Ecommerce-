import 'package:clot/core/ui/components/app_back_button.dart';
import 'package:clot/core/ui/components/app_text.dart';
import 'package:clot/core/ui/components/layouts/app_scaffold.dart';
import 'package:clot/core/ui/extensions/app_theme_extension.dart';
import 'package:clot/core/variables/product_card.dart';
import 'package:clot/features/products/data/products_data.dart';
import 'package:clot/features/products/bloc/top_selling/bloc/top_selling_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSellingScreen extends StatefulWidget {
  const TopSellingScreen({super.key});

  @override
  State<TopSellingScreen> createState() => _TopSellingScreenState();
}

class _TopSellingScreenState extends State<TopSellingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopSellingBloc(
        productsRepository: ProductsDataImpl(),
      )..add(const FetchTopSelling()),
      child: AppScaffold(
        appbar: AppBar(
          leading: const AppBackButton(),
          forceMaterialTransparency: true,
          title: AppText(
            'Top Selling',
            style: context.textTheme.headlineLarge,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TopSellingBloc, TopSellingState>(
                builder: (context, state) {
                  if (state is TopSellingLoading) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is TopSellingFailure) {
                    return SizedBox(
                      height: 100,
                      child: Center(child: AppText(state.errorMessage)),
                    );
                  }

                  if (state is TopSellingLoaded) {
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
