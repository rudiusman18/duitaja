import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<Map<String, List<String>>> {
  FilterCubit() : super({});

  void setFilter(Map<String, List<String>> filter) {
    emit(filter);
  }
}
