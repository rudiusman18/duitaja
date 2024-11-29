import 'package:bloc/bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);

  void setPage(int pageNumber) {
    emit(pageNumber);
  }
}

class PreviousPageCubit extends Cubit<int> {
  PreviousPageCubit() : super(0);
  void setPage(int pageNumber) {
    emit(pageNumber);
  }
}
