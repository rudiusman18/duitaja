import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/filter_cubit.dart';
import 'package:duitaja/cubit/home_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/shared/sale_detail_page.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<SaleCubit>().allSalesHistory(
          token: context.read<AuthCubit>().token ?? "",
          page: "1",
          limit: "15",
          status: "",
          startDate: "",
          endDate: "",
          search: "",
          inStatus: "",
        );
    super.initState();
  }

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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/main-page/profile-page');
              },
              child: ClipOval(
                child: Image.asset(
                  "assets/default picture.png",
                  width: 50,
                  height: 50,
                ),
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
                  "${context.read<AuthCubit>().profileModel.payload?.profile?.name}",
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

    Widget reportCard({
      required String title,
      required String asset,
      required String message,
      required String subtitle,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.symmetric(
            //   horizontal: 35,
            // ),
            padding: const EdgeInsets.symmetric(
              vertical: 17,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(6),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/card-background.png',
                ),
                fit: BoxFit.cover,
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
                        child: Text(title,
                            style: inter.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        message,
                        style: inter.copyWith(
                          fontSize: title.toLowerCase() == "sandiai" ? 14 : 25,
                          fontWeight: title.toLowerCase() == "sandiai"
                              ? regular
                              : semiBold,
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                      if (title.toLowerCase() != "sandiai") ...{
                        const SizedBox(
                          height: 16,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            subtitle,
                            style: inter.copyWith(
                              fontSize: 13,
                              fontWeight: medium,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      } else ...{
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Selengkapnya",
                            style: inter.copyWith(
                              fontSize: 10,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      },
                    ],
                  ),
                ),
                Image.asset(
                  asset,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        ],
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
      required String payloadId,
      required String buyerName,
      required String orderAmount,
      required String date,
      required String time,
      required String status,
      required String price,
    }) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return SaleDetailPage(saleId: payloadId);
              });
        },
        child: Container(
          color: Colors.white,
          child: Column(
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
                    const SizedBox(
                      width: 20,
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
                            color: status.toLowerCase() == "lunas"
                                ? Colors.green
                                : status.toLowerCase() == "refund"
                                    ? Colors.blue
                                    : Colors.red,
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
          ),
        ),
      );
    }

    return BlocConsumer<SaleCubit, SaleState>(
      listener: (context, state) {
        if (state is SaleTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
        if (state is SaleReset) {
          context.read<SaleCubit>().allSalesHistory(
                token: context.read<AuthCubit>().token ?? "",
                page: "1",
                limit: "15",
                status: "",
                startDate: "",
                endDate: "",
                search: "",
                inStatus: "",
              );
        }
      },
      builder: (context, state) {
        return BlocBuilder<ReportCardIndexCubit, int>(
          builder: (context, state) {
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
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            initialPage:
                                context.read<ReportCardIndexCubit>().state,
                            height: 150,
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              context
                                  .read<ReportCardIndexCubit>()
                                  .setIndex(index);
                            },
                          ),
                          items: [
                            reportCard(
                              title: "SandiAI",
                              message:
                                  "50 juta diperlukan untuk mengelola operasional dan pembayaran hutang di bulan depan.",
                              subtitle: "+20% dari bulan lalu",
                              asset: "assets/Magicpen.png",
                            ),
                            reportCard(
                              title: "Penjualan bulan ini",
                              message: formatCurrency(45231),
                              subtitle: "+20% dari bulan lalu",
                              asset: "assets/calendar-check.png",
                            ),
                            reportCard(
                              title: "Penjualan hari ini",
                              message: formatCurrency(45231),
                              subtitle: "+20% dari bulan lalu",
                              asset: "assets/Chart_alt_fill.png",
                            ),
                            reportCard(
                              title: "Produk terlaris hari ini",
                              message: "Nasi Goreng",
                              subtitle: "150 Terjual",
                              asset: "assets/subtract.png",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DotsIndicator(
                        dotsCount: 4,
                        position: context.read<ReportCardIndexCubit>().state,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<DetailSaleCubit>()
                                              .clearSalesHistory();
                                          Navigator.pushNamed(
                                            context,
                                            '/main-page/cashier-page',
                                          );
                                        },
                                        child: generateMenuItem(
                                          title: "Kasir",
                                          image: "assets/cart.png",
                                        ),
                                      ),
                                      generateMenuItem(
                                        title: "E-Commerce",
                                        image: "assets/chart.png",
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<FilterCubit>()
                                              .setFilter({});
                                          Navigator.pushNamed(context,
                                              '/main-page/stock-opname-page');
                                        },
                                        child: generateMenuItem(
                                          title: "Stok Opname",
                                          image: "assets/desk.png",
                                        ),
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
                                child: RefreshIndicator(
                                  color: primaryColor,
                                  onRefresh: () {
                                    context
                                        .read<SaleCubit>()
                                        .resetSalesHistory();
                                    return context
                                        .read<SaleCubit>()
                                        .allSalesHistory(
                                            token: context
                                                    .read<AuthCubit>()
                                                    .token ??
                                                "",
                                            page: "1",
                                            limit: "15",
                                            status: "",
                                            startDate: "",
                                            endDate: "",
                                            search: "",
                                            inStatus: "");
                                  },
                                  child: state is SaleLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : (context
                                                          .read<SaleCubit>()
                                                          .saleHistoryModel
                                                          .payload
                                                          ?.isEmpty ??
                                                      true) &&
                                                  state is SaleSuccess ||
                                              state is SaleFailure
                                          ? Center(
                                              child: Text(
                                                "Data tidak ditemukan",
                                                style: inter,
                                              ),
                                            )
                                          : ListView(
                                              children: [
                                                for (var i = 0;
                                                    i <
                                                        (context
                                                                .read<
                                                                    SaleCubit>()
                                                                .saleHistoryModel
                                                                .payload
                                                                ?.length ??
                                                            0);
                                                    i++)
                                                  generateSalesHistoryItem(
                                                    payloadId:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].id}",
                                                    buyerName:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].customerName}",
                                                    orderAmount:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].countSale}",
                                                    date:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].createdAt?.split(" ").first}",
                                                    time:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].createdAt?.split(" ").last}",
                                                    status:
                                                        "${context.read<SaleCubit>().saleHistoryModel.payload?[i].status}",
                                                    price: formatCurrency(context
                                                            .read<SaleCubit>()
                                                            .saleHistoryModel
                                                            .payload?[i]
                                                            .subTotal ??
                                                        0),
                                                  ),
                                              ],
                                            ),
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
          },
        );
      },
    );
  }
}
