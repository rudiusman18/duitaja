import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class ReportDetailPage extends StatelessWidget {
  const ReportDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          generateReportItem(
            title: "Judul: ",
            value: "Stok Opname November",
          ),
          generateReportItem(
            title: "Nama: ",
            value: "Sandi",
          ),
          generateReportItem(
            title: "Tanggal: ",
            value: "15 November 2024",
          ),
          generateReportItem(
            title: "Total Produk: ",
            value: "5",
          ),
          const SizedBox(
            height: 12,
          ),
          generateProductCard(
            productName: "Mie Goreng",
            expiredDate: "29/11/2025",
            input: "100 pcs",
            output: "80 pcs",
            systemStock: "20 pcs",
            realStock: "20 pcs",
            differenceStock: "-",
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.chevron_left,
                color: greyColor2,
              ),
              Text(
                "1/5",
                style: inter.copyWith(
                  fontWeight: medium,
                ),
              ),
              const Icon(
                Icons.chevron_right,
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
  }
}
