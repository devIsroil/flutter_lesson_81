import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homework/app.dart';
import 'homework/blocs/products_bloc.dart';
import 'homework/data/repositories/products_repository.dart';
import 'homework/data/services/dio_product_service.dart';

void main() {
  final dioProductService = DioProductsService();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          return ProductsRepository(dioProductsService: dioProductService);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProductsBloc(
                productsRepository: context.read<ProductsRepository>(),
              );
            },
          ),
        ],
        child: const MainApp(),
      ),
    ),
  );
}