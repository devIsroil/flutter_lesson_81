


import '../models/product.dart';
import '../services/dio_product_service.dart';

class ProductsRepository {
  final DioProductsService _dioProductsService;

  ProductsRepository({required DioProductsService dioProductsService})
      : _dioProductsService = dioProductsService;

  Future<List<Product>> getProducts() async {
    return await _dioProductsService.getProducts();
  }
  Future<void> deleteProducts(String id) async {
    return await _dioProductsService.deleteProduct(id);
  }
}
