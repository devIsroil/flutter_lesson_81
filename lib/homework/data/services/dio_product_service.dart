import 'package:dio/dio.dart';
import '../models/product.dart';

class DioProductsService {
  final Dio _dioClient = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dioClient.get("https://api.escuelajs.co/api/v1/products");

      List<Product> products = [];

      for (var productData in response.data) {
        products.add(Product.fromMap(productData));
      }

      return products;
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e.response?.data);
      rethrow;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _dioClient.delete('https://api.escuelajs.co/api/v1/products/$id');
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e.response?.data);
      rethrow;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }
}
