import 'package:bloc/bloc.dart';
import 'package:duidku/model/product_model.dart';

class IndexCashierFilterCubit extends Cubit<int> {
  IndexCashierFilterCubit() : super(0);

  void setIndex(int index) {
    emit(index);
  }
}

class ProductCartCubit extends Cubit<List<ProductModel>> {
  ProductCartCubit() : super([]);

  void addProduct(List<ProductModel> products) {
    emit(products);
  }
}
