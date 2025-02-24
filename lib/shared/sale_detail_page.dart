import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/model/detail_sale_history_model.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaleDetailPage extends StatefulWidget {
  final String saleId;
  final bool? paymentStatus;
  const SaleDetailPage({super.key, required this.saleId, this.paymentStatus});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  DetailSaleHistoryModel detailSaleHistoryModel = DetailSaleHistoryModel();

  @override
  void initState() {
    context.read<DetailSaleCubit>().detailSalesHistory(
          token: context.read<AuthCubit>().token ?? "",
          payloadId: widget.saleId,
        );
    context
        .read<CashierCubit>()
        .tax(token: context.read<AuthCubit>().token ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget generateInfoitem({required String title, required String value}) {
      return Row(
        children: [
          Text(
            title,
            style: inter.copyWith(fontSize: 15, fontWeight: semiBold),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              value,
              style: inter,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    }

    Widget generateInvoiceItem({required InvoiceItems? invoiceItem}) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${invoiceItem?.name}",
                  style: inter,
                ),
                Text(
                    "${invoiceItem?.quantity} x ${formatCurrency((invoiceItem?.price ?? 0) - (invoiceItem?.promoAmount ?? 0))}")
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(formatCurrency(invoiceItem?.resultTotal ?? 0))
        ],
      );
    }

    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          generateInfoitem(
            title: "ID Pesanan: ",
            value: "${detailSaleHistoryModel.payload?.invoiceNumber}",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Nama Pelanggan: ",
            value: detailSaleHistoryModel.payload?.customerName ?? "",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "No Hp: ",
            value: (detailSaleHistoryModel.payload?.phoneNumber ?? "") == ""
                ? "-"
                : detailSaleHistoryModel.payload?.phoneNumber ?? "",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Tanggal: ",
            value: detailSaleHistoryModel.payload?.createdAt ?? "",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Status: ",
            value: detailSaleHistoryModel.payload?.status ?? "",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Detail Pesanan: ",
            value: "",
          ),
          for (var i = 0;
              i < (detailSaleHistoryModel.payload?.invoiceItems?.length ?? 0);
              i++) ...{
            generateInvoiceItem(
                invoiceItem: detailSaleHistoryModel.payload?.invoiceItems?[i])
          },
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Catatan: ",
            value: (detailSaleHistoryModel.payload?.note ?? "-") == ""
                ? "-"
                : detailSaleHistoryModel.payload?.note ?? "-",
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Sub Total: ",
            value:
                formatCurrency(detailSaleHistoryModel.payload?.subTotal ?? 0),
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title:
                "PPN (${context.read<CashierCubit>().taxModel.payload?.first.precentage}%): ",
            value: formatCurrency(detailSaleHistoryModel.payload?.tax ?? 0),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "TOTAL: ",
            value: (formatCurrency(
                (detailSaleHistoryModel.payload?.subTotal ?? 0) +
                    (detailSaleHistoryModel.payload?.tax ?? 0))),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Pembayaran (Cash): ",
            value: (formatCurrency(
                (detailSaleHistoryModel.payload?.subTotal ?? 0) +
                    (detailSaleHistoryModel.payload?.tax ?? 0))),
          ),
          const SizedBox(
            height: 16,
          ),
          generateInfoitem(
            title: "Kembalian: ",
            value: (formatCurrency(0)),
          ),
          if (widget.paymentStatus == null) ...{
            if ((detailSaleHistoryModel.payload?.status ?? "").toLowerCase() ==
                "lunas") ...{
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    context.read<RefundSaleCubit>().refundSalesHistory(
                          token: context.read<AuthCubit>().token ?? "",
                          payloadId: detailSaleHistoryModel.payload?.id ?? "",
                        );
                  },
                  child: Text(
                    "Refund",
                    style: inter,
                  ),
                ),
              ),
            },
            if ((detailSaleHistoryModel.payload?.status ?? "").toLowerCase() ==
                "belum lunas") ...{
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/main-page/cashier-page');
                    },
                    child: Text(
                      "Tambah Pesanan",
                      style: inter.copyWith(fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Bayar Sekarang",
                      style: inter.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            }
          }
        ],
      );
    }

    return BlocListener<RefundSaleCubit, RefundSaleState>(
      listener: (context, state) {
        if (state is RefundSaleSuccess) {
          context.read<SaleCubit>().resetSalesHistory();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Data berhasil diubah",
                style: inter,
              ),
              backgroundColor: Colors.green,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }
        if (state is RefundSaleFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: inter,
              ),
              backgroundColor: Colors.red,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }
        if (state is RefundSaleTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      child: BlocBuilder<CashierCubit, CashierState>(
        builder: (context, state) {
          return BlocConsumer<DetailSaleCubit, DetailSaleState>(
            listener: (context, state) {
              if (state is DetailSaleTokenExpired) {
                context.read<AuthCubit>().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }

              if (state is DetailSaleSuccess) {
                detailSaleHistoryModel = state.detailData;
              }
            },
            builder: (context, state) {
              return state is DetailSaleLoading
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      ],
                    )
                  : widget.paymentStatus != null
                      ? content()
                      : AlertDialog(
                          content: content(),
                        );
            },
          );
        },
      ),
    );
  }
}
