import 'package:duitaja/cubit/page_cubit.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/ui/stock_page.dart';
import 'package:duitaja/ui/home_page.dart';
import 'package:duitaja/ui/sale_page.dart';
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
          return StockPage(
            clearFilterCubit: context.read<PageCubit>().state !=
                    context.read<PreviousPageCubit>().state
                ? true
                : false,
          );
        case 2:
          return SalePage(
            clearFilterCubit: context.read<PageCubit>().state !=
                    context.read<PreviousPageCubit>().state
                ? true
                : false,
          );
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
                inter.copyWith(fontSize: 10, color: greyColor),
            iconSize: 24,
            selectedItemColor: primaryColor,
            unselectedItemColor: greyColor,
            onTap: (int index) {
              context
                  .read<PreviousPageCubit>()
                  .setPage(context.read<PageCubit>().state);
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
                      : greyColor,
                  width: 24,
                ),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/package_search.png',
                  fit: BoxFit.cover,
                  color: context.read<PageCubit>().state == 1
                      ? primaryColor
                      : greyColor,
                  width: 24,
                ),
                label: "Stok Manajemen",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/paper.png',
                  fit: BoxFit.cover,
                  color: context.read<PageCubit>().state == 2
                      ? primaryColor
                      : greyColor,
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
