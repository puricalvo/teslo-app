import '../entities/product.dart';


abstract class ProductsRepository {

  Future<List<Product>> getProductsByPage({ int limit = 10, int offset = 0 });
  Future<Product> getProductsById(String id);

  Future<List<Product>> searchProductByTerm(String term );
  
  Future<Product> createUpdateProduct( Map<String,dynamic> productLike );

}
