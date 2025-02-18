import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/stock_opname_cubit.dart';
import 'package:duitaja/model/detail_stock_opname_model.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({super.key});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  DetailStockOpnameModel? detailStockOpnameModel;
  int cardIndex = 0;
  DateTime? dateTime;
  String? date;

  TextEditingController searchTextField = TextEditingController(text: "");

  @override
  void initState() {
    context.read<StockOpnameDetailCubit>().detailStockOpname(
        token: context.read<AuthCubit>().token ?? "",
        stockOpnameID:
            context.read<StockOpnameDetailCubit>().stockData.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchSetup() {
      return TextFormField(
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
          hintText: "Cari Produk...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    Widget generateReportItem({
      required String title,
      required String value,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor1,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: inter.copyWith(
                fontWeight: semiBold,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: inter.copyWith(
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
    }

    Widget generateProductCardItem({
      required String title,
      required String value,
    }) {
      return Row(
        children: [
          Text(
            title,
            style: inter,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              style: inter,
              textAlign: TextAlign.end,
            ),
          )
        ],
      );
    }

    Widget generateProductCard({
      required String productName,
      required String expiredDate,
      required String input,
      required String output,
      required String systemStock,
      required String realStock,
      required String differenceStock,
    }) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 33,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: greyColor1,
            )),
        child: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Produk :",
              value: productName,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "kadaluarsa :",
              value: expiredDate,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Masuk :",
              value: input,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Keluar :",
              value: output,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Stok Sistem :",
              value: systemStock,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Stok Asli :",
              value: realStock,
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Selisih :",
              value: differenceStock,
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      );
    }

    return BlocConsumer<StockOpnameDetailCubit, StockOpnameDetailState>(
      listener: (context, state) {
        if (state is StockOpnameDetailTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }

        if (state is StockOpnameDetailSuccess) {
          detailStockOpnameModel = state.detailStockOpnameData;
          dateTime =
              DateTime.parse(detailStockOpnameModel?.payload?.createdAt ?? "")
                  .toLocal();
          date = "${dateTime?.year}-${dateTime?.month}-${dateTime?.day}";
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Detail Laporan",
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
          body: state is StockOpnameDetailLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : state is StockOpnameDetailFailure ||
                      detailStockOpnameModel == null
                  ? Center(
                      child: Text(
                        'Data tidak ditemukan',
                        style: inter,
                      ),
                    )
                  : ListView(
                      children: [
                        generateReportItem(
                          title: "Judul: ",
                          value: "${detailStockOpnameModel?.payload?.title}",
                        ),
                        generateReportItem(
                          title: "Nama: ",
                          value:
                              "${detailStockOpnameModel?.payload?.changerName}",
                        ),
                        generateReportItem(
                          title: "Tanggal: ",
                          value: date ?? "-",
                        ),
                        generateReportItem(
                          title: "Total Produk: ",
                          value:
                              "${detailStockOpnameModel?.payload?.items?.length ?? 0}",
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 164,
                                ),
                                child: searchSetup(),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: greyColor1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.lock_outline),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        generateProductCard(
                          productName:
                              "${detailStockOpnameModel?.payload?.items?[cardIndex].name}",
                          expiredDate: "tanggal expired belum ditemukan",
                          input: "belum ditemukan",
                          output: "belum ditemukan",
                          systemStock:
                              "${detailStockOpnameModel?.payload?.items?[cardIndex].quantity}",
                          realStock: "belum ditemukan",
                          differenceStock:
                              "${detailStockOpnameModel?.payload?.items?[cardIndex].differenceQuantity}",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (cardIndex != 0) {
                                    cardIndex -= 1;
                                  }
                                });
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color:
                                    cardIndex == 0 ? greyColor1 : Colors.black,
                              ),
                            ),
                            Text(
                              "${cardIndex + 1}/${detailStockOpnameModel?.payload?.items?.length ?? 0}",
                              style: inter.copyWith(
                                fontWeight: medium,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (cardIndex <
                                      (detailStockOpnameModel
                                                  ?.payload?.items?.length ??
                                              0) -
                                          1) {
                                    cardIndex += 1;
                                  }
                                });
                              },
                              child: Icon(
                                Icons.chevron_right,
                                color: cardIndex ==
                                        (detailStockOpnameModel
                                                    ?.payload?.items?.length ??
                                                0) -
                                            1
                                    ? greyColor1
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 136,
                                  child: ElevatedButton(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
