part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {}

final class AddProductEvent extends ProductsEvent {}

final class EditProductEvent extends ProductsEvent {}

class DeleteProductEvent extends ProductsEvent {
  final String productId;

  DeleteProductEvent(this.productId);
}