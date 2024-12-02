import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCardIndexCubit extends Cubit<int> {
  ReportCardIndexCubit() : super(0);

  void setIndex(int index) {
    emit(index);
  }
}
