import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

//PROVIDER
final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>
( (ref, productId ) {

  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
    productsRepository: productsRepository,
    productId: productId
  );
});



// NOTIFIER
class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }):super(ProductState(id: productId)) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 'new', 
      title: '', 
      price: 0, 
      description: '', 
      slug: '', 
      stock: 0, 
      sizes: [], 
      gender: 'men', 
      tags: [], 
      images: [], 
    );
  }


  Future<void> loadProduct() async {

    try {

      if ( state.id == 'new' ) {
        state = state.copywith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }

      final product = await productsRepository.getProductsById(state.id);

      state = state.copywith(
        isLoading: false,
        product: product
      );

    } catch (e) {

      print(e);
    }


  }
}



// STATE
class ProductState {

  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id, 
    this.product, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  ProductState copywith({
   String? id,
   Product? product,
   bool? isLoading,
   bool? isSaving,
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );

}