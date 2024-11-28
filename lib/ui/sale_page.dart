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

    Widget generateFilterContentItem({
      required String name,
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
              horizontal: 41,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: greyColor1,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: greyColor1,
          ),
        ],
      );
    }

// ignore: no_leading_underscores_for_local_identifiers
    void _showBottomSheet(BuildContext context, {required String title}) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          return SizedBox(
            height: 472,
            child: Column(
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
                    horizontal: 11,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Text(
                        "Pilih $title",
                        style: inter.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if (title.toLowerCase() == "penjualan") ...{
                        generateFilterContentItem(name: "Semua Penjualan"),
                        generateFilterContentItem(name: "Kasir"),
                        generateFilterContentItem(name: "Tokopedia"),
                        generateFilterContentItem(name: "TiktokShop"),
                        generateFilterContentItem(name: "Shopee"),
                        generateFilterContentItem(name: "GoFood"),
                      } else if (title.toLowerCase() == "status") ...{
                        generateFilterContentItem(name: "Semua Status"),
                        generateFilterContentItem(name: "Lunas"),
                        generateFilterContentItem(name: "Belum Lunas"),
                      } else ...{
                        generateFilterContentItem(name: "Semua Tanggal"),
                        generateFilterContentItem(name: "30 Hari Terakhir"),
                        generateFilterContentItem(name: "90 Hari Terakhir"),
                        generateFilterContentItem(name: "Atur Tanggal"),
                      },
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget generateFilterItem({required String title}) {
      return GestureDetector(
        onTap: () {
          _showBottomSheet(
            context,
            title: title,
          );
        },
        child: Container(
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
      body: SafeArea(
        child: Column(
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
      ),
    );
  }
}
