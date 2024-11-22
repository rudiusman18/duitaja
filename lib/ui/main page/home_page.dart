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
                  child: ListView(
                    children: [],
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
