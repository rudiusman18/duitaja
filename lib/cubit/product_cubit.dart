import 'package:duidku/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductModel> {
  ProductCubit()
      : super(
          ProductModel(
            productId: 0,
            productCategory: '',
            productURL: '',
            productName: '',
            stock: -1,
            description: '',
            price: -1,
            discountPrice: -1,
            status: '',
          ),
        );

  void setProduct(ProductModel product) {
    emit(product);
  }

  void addStock(ProductModel product) {
    var productData = product;
    productData.stock = (productData.stock ?? 0) + 1;
    emit(productData);
  }

  void removeStock(ProductModel product) {
    var productData = product;
    productData.stock =
        (productData.stock ?? 0) == 0 ? 0 : (productData.stock ?? 0) - 1;
    emit(productData);
  }
}
