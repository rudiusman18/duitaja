import 'package:dots_indicator/dots_indicator.dart';
import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget profile() {
      return Container(
        margin: const EdgeInsets.only(
          left: 24,
          top: 33,
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                "assets/default picture.png",
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang,",
                  style: inter.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Sandi Aristio",
                  style: inter.copyWith(
                    fontSize: 25,
                    fontWeight: semiBold,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget reportCard() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [
              cardColor2.withAlpha(99),
              cardColor1,
              cardColor2,
            ],
          ),
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
                    child: Text("Penjualan Bulan Ini",
                        style: inter.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Rp 45,231.00",
                      style: inter.copyWith(
                        fontSize: 25,
                        fontWeight: semiBold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "+20% dari bulan lalu",
                      style: inter.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/calendar-check.png",
              width: 24,
              height: 24,
            ),
          ],
        ),
      );
    }

    Widget generateMenuItem({
      required String title,
      required String image,
    }) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: greyColor,
              ),
            ),
            child: Image.asset(
              image,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: inter.copyWith(
              fontSize: 10,
              fontWeight: medium,
            ),
          ),
        ],
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
            color: greyColor600,
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
      backgroundColor: primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withAlpha(99),
              primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              profile(),
              const SizedBox(
                height: 24,
              ),
              reportCard(),
              const SizedBox(
                height: 16,
              ),
              DotsIndicator(
                dotsCount: 3,
                decorator: DotsDecorator(
                  activeColor: cardColor2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 11,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              generateMenuItem(
                                title: "Kasir",
                                image: "assets/cart.png",
                              ),
                              generateMenuItem(
                                title: "E-Commerce",
                                image: "assets/chart.png",
                              ),
                              generateMenuItem(
                                title: "Stok Opname",
                                image: "assets/desk.png",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: Text(
                          "Riwayat Penjualan",
                          style: inter.copyWith(
                            fontWeight: medium,
                            fontSize: 13,
                            color: greyColor,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
