import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  TextEditingController menuSearchTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: TextFormField(
          controller: menuSearchTextField,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: greyColor600,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            hintText: "Cari menu...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                9999,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                9999,
              ),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
        ),
      );
    }

    Widget itemFilter({
      required String name,
      required bool isSelected,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 11,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : filterGreyColor,
          ),
          color: isSelected ? purpleColor1 : Colors.transparent,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            name,
            style: inter.copyWith(
              fontWeight: medium,
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    Widget filterSetup() {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<IndexCashierFilterCubit>().setIndex(0);
                },
                child: itemFilter(
                  name: "Semua",
                  isSelected: context.read<IndexCashierFilterCubit>().state == 0
                      ? true
                      : false,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<IndexCashierFilterCubit>().setIndex(1);
                },
                child: itemFilter(
                  name: "Kopi",
                  isSelected: context.read<IndexCashierFilterCubit>().state == 1
                      ? true
                      : false,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<IndexCashierFilterCubit>().setIndex(2);
                },
                child: itemFilter(
                  name: "Makanan",
                  isSelected: context.read<IndexCashierFilterCubit>().state == 2
                      ? true
                      : false,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<IndexCashierFilterCubit>().setIndex(3);
                },
                child: itemFilter(
                  name: "Minuman",
                  isSelected: context.read<IndexCashierFilterCubit>().state == 3
                      ? true
                      : false,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      );
    }

    Widget orderListItem({
      required String name,
      required String status,
      required String orderID,
      required String numberOfItems,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: greyColor1,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: inter.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    status,
                    style: inter.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 21,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  orderID,
                  style: inter.copyWith(
                    fontWeight: extraLight,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  numberOfItems,
                  style: inter.copyWith(
                    fontSize: 12,
                    fontWeight: extraLight,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget orderListSetup() {
      return ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment
                .center, // Ensures alignment consistency
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false, // Disable default arrow icon
          ),
          header: Container(
            margin: const EdgeInsets.only(
              bottom: 18,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Daftar Pesanan",
                  textAlign: TextAlign.center, // Center align the text
                  style: inter.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  "15",
                  textAlign: TextAlign.center, // Center align the text
                  style: inter.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                ),
                const Icon(
                  Icons.expand_more, // Icon for expand/collapse
                  size: 24,
                ),
              ],
            ),
          ),
          collapsed: const SizedBox(),
          expanded: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < 15; i++) ...{
                    i == 0
                        ? const SizedBox()
                        : const SizedBox(
                            width: 23,
                          ),
                    orderListItem(
                      name: "Arief",
                      status: "Belum Lunas",
                      orderID: "#230734",
                      numberOfItems: "5 barang",
                    ),
                  }
                ],
              ),
            ),
          ));
    }

    Widget itemMenuListSetup({
      required String productURL,
      required String productName,
      required String stock,
      required String description,
      required String price,
    }) {
      return Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: greyColor1,
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(
                        productURL,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: inter.copyWith(
                          fontWeight: semiBold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Stok : $stock",
                        style: inter.copyWith(
                          fontSize: 12,
                          fontWeight: extraLight,
                        ),
                      ),
                      Text(
                        description,
                        style: inter.copyWith(
                          fontSize: 12,
                          fontWeight: extraLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      price,
                      style: inter.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      );
    }

    return BlocBuilder<IndexCashierFilterCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Kasir",
              style: inter.copyWith(
                fontWeight: medium,
                fontSize: 20,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.chevron_left,
                size: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              searchSetup(),
              const SizedBox(
                height: 36,
              ),
              filterSetup(),
              const SizedBox(
                height: 24,
              ),
              orderListSetup(),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Menu",
                  textAlign: TextAlign.center, // Center align the text
                  style: inter.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var i = 0; i < 20; i++)
                      itemMenuListSetup(
                        productURL:
                            "https://i.pinimg.com/originals/73/5a/31/735a3179ff4baf792989573c363b2af9.jpg",
                        productName: "Mie Goreng",
                        price: "Rp. 123.000",
                        description:
                            "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet",
                        stock: "5",
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
