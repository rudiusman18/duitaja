part of 'product_menu_cubit.dart';

@immutable
sealed class ProductMenuState {}

final class ProductMenuInitial extends ProductMenuState {}

final class ProductMenuLoading extends ProductMenuState {}

final class ProductMenuSuccess extends ProductMenuState {}

final class ProductMenuFailure extends ProductMenuState {}
