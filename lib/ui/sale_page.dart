import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:duidku/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  TextEditingController searchTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: searchTextField,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: greyColor600,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  hintText: "Cari...",
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
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Ekspor",
                style: inter.copyWith(
                  fontWeight: medium,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget generateFilterItem({required String title}) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: disableColor,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: inter.copyWith(
                color: primaryColor,
                fontWeight: medium,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: disableColor,
            )
          ],
        ),
      );
    }

    Widget generateSalesHistoryItem({
      required String buyerName,
      required String orderAmount,
      required String date,
      required String time,
      required String status,
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
              horizontal: 31,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          buyerName,
                          style: inter.copyWith(
                            fontSize: 15,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$orderAmount Pesanan",
                          style: inter.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$date|$time",
                          style: inter.copyWith(
                            fontSize: 10,
                            fontWeight: medium,
                            color: greyColor600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Text(
                        status,
                        style: inter.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      price,
                      style: inter.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }

// ignore: no_leading_underscores_for_local_identifiers
    void _showBottomSheet(BuildContext context,
        {required ProductModel product}) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min, // Adjusts height to fit content
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 13),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 23,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            product.productURL ?? "",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName ?? "",
                            style: inter.copyWith(
                              fontSize: 15,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            "Stok: ${product.stock ?? 0}",
                            style: inter.copyWith(
                              fontSize: 12,
                              fontWeight: extraLight,
                            ),
                          ),
                          Text(
                            product.description ?? "",
                            style: inter.copyWith(
                              fontSize: 12,
                              fontWeight: extraLight,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Text(
                                formatCurrency(
                                  product.discountPrice == 0
                                      ? product.price ?? 0
                                      : product.discountPrice ?? 0,
                                ),
                                style: inter.copyWith(
                                  fontSize: 15,
                                  fontWeight: semiBold,
                                ),
                              ),
                              if (product.discountPrice != 0) ...{
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  formatCurrency(
                                    product.price ?? 0,
                                  ),
                                  style: inter.copyWith(
                                    fontSize: 10,
                                    fontWeight: medium,
                                    color: greyColor2,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              },
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                var products =
                                    context.read<ProductCartCubit>().state;
                                products.add(product);
                                context
                                    .read<ProductCartCubit>()
                                    .addProduct(products);
                                setState(() {});
                              },
                              child: Text(
                                "Tambah Pesanan",
                                style: inter.copyWith(
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Penjualan",
          style: inter.copyWith(
            fontWeight: medium,
            fontSize: 20,
          ),
        ),
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          searchSetup(),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    generateFilterItem(
                      title: "Penjualan",
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    generateFilterItem(
                      title: "Status",
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    generateFilterItem(
                      title: "Tanggal",
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              children: [
                for (var i = 0; i < 20; i++)
                  generateSalesHistoryItem(
                    buyerName: "Imam",
                    orderAmount: "4",
                    date: "15 November 2024",
                    time: "15:28PM",
                    status: "Lunas",
                    price: "Rp. 123.000",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
