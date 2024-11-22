import 'dart:ffi';

import 'package:duidku/cubit/page_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:duidku/ui/main%20page/cashier_page.dart';
import 'package:duidku/ui/main%20page/home_page.dart';
import 'package:duidku/ui/main%20page/sale_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Widget body({required int currentIndex}) {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const CashierPage();
        case 2:
          return const SalePage();
        default:
          return const HomePage();
      }
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: body(currentIndex: state),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle:
                inter.copyWith(fontSize: 10, color: primaryColor),
            unselectedLabelStyle:
                inter.copyWith(fontSize: 10, color: disableColor),
            iconSize: 24,
            selectedItemColor: primaryColor,
            unselectedItemColor: disableColor,
            onTap: (int index) {
              context.read<PageCubit>().setPage(index);
            },
            currentIndex: context.read<PageCubit>().state,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/home.png',
                  fit: BoxFit.cover,
                  color: context.read<PageCubit>().state == 0
                      ? primaryColor
                      : disableColor,
                  width: 24,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/cart.png',
                  fit: BoxFit.cover,
                  color: context.read<PageCubit>().state == 1
                      ? primaryColor
                      : disableColor,
                  width: 24,
                ),
                label: "Kasir",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/paper.png',
                  fit: BoxFit.cover,
                  color: context.read<PageCubit>().state == 2
                      ? primaryColor
                      : disableColor,
                  width: 24,
                ),
                label: "Penjualan",
              ),
            ],
          ),
        );
      },
    );
  }
}
