import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_menu_state.dart';

class ProductMenuCubit extends Cubit<ProductMenuState> {
  ProductMenuCubit() : super(ProductMenuInitial());
}
