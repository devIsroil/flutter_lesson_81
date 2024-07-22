import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/products_bloc.dart';
import '../../data/models/product.dart';


class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  void getUser() {
    context.read<ProductsBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorProductsState) {
            return Center(
              child: Text(state.message),
            );
          }

          List<Product> users = [];

          if (state is LoadedProductsState) {
            users = state.products;
          }

          return users.isEmpty
              ? const Center(
            child: Text("Mavjud emas"),
          )
              : ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              final user = users[index];
              return ListTile(
                leading: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      user.images[0].split('"')[1],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/not.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    )),
                title: Text("${user.title} $index"),
                subtitle: Text(user.images[0].split('"')[1]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<ProductsBloc>()
                              .add(DeleteProductEvent(user.id));
                          // getUser();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}