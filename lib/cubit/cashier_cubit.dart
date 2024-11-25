import 'package:bloc/bloc.dart';

class IndexCashierFilterCubit extends Cubit<int> {
  IndexCashierFilterCubit() : super(0);

  void setIndex(int index) {
    emit(index);
  }
}
