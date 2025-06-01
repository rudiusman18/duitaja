// ignore_for_file: equal_elements_in_set

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bluetooth_print_plus/bluetooth_print_plus.dart' as bt;
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/model/detail_sale_history_model.dart';
import 'package:duitaja/model/order_model.dart';
import 'package:duitaja/model/tax_model.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SaleDetailPage extends StatefulWidget {
  final String saleId;
  final bool? paymentStatus;
  final bool? detailOrder;
  const SaleDetailPage(
      {super.key, required this.saleId, this.paymentStatus, this.detailOrder});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  DetailSaleHistoryModel detailSaleHistoryModel = DetailSaleHistoryModel();
  List<Purchaseds>? purchaseds = [];

  @override
  void initState() {
    context.read<DetailSaleCubit>().detailSalesHistory(
          token: context.read<AuthCubit>().token ?? "",
          payloadId: widget.saleId,
          savedOrder: context.read<DetailSaleCubit>().dataToAddOrderModel,
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
                    "${invoiceItem?.quantity} x ${formatCurrency((invoiceItem?.price ?? 0) - (invoiceItem?.promo?.type == 'PERCENT' ? (((invoiceItem?.price ?? 0) * (invoiceItem?.promoAmount ?? 0) ~/ 100)) : (invoiceItem?.promoAmount ?? 0)))}")
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

    Widget content(int? taxPercentage) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/close.png",
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          if ((detailSaleHistoryModel.payload?.status ?? "").toLowerCase() ==
              "lunas") ...{
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => PrinterPage(
                      detailSaleHistoryModel: detailSaleHistoryModel,
                      taxModel: context.read<CashierCubit>().taxModel,
                      detailOrder: widget.detailOrder,
                    ),
                  );
                },
                child: Image.asset(
                  "assets/download.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
          },
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
          if (widget.detailOrder == null) ...{
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
                  (detailSaleHistoryModel.payload?.moneyReceived ?? 0))),
            ),
            const SizedBox(
              height: 16,
            ),
            generateInfoitem(
              title: "Kembalian: ",
              value: (formatCurrency(
                  (detailSaleHistoryModel.payload?.moneyBack ?? 0))),
            ),
            if (widget.paymentStatus == null) ...{
              if ((detailSaleHistoryModel.payload?.status ?? "")
                      .toLowerCase() ==
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
              if ((detailSaleHistoryModel.payload?.status ?? "")
                      .toLowerCase() ==
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
                        context
                            .read<DetailSaleCubit>()
                            .detailSalesHistoryToAddOrder(
                                detailSaleHistoryModel: detailSaleHistoryModel);

                        Navigator.pushReplacementNamed(
                            context, '/main-page/cashier-page');
                      },
                      child: Text(
                        "Tambah Pesanan",
                        style: inter.copyWith(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        OrderModel orderModel = OrderModel(
                          customerName:
                              detailSaleHistoryModel.payload?.customerName,
                          phoneNumber:
                              detailSaleHistoryModel.payload?.phoneNumber == ""
                                  ? null
                                  : detailSaleHistoryModel.payload?.phoneNumber,
                          notes: detailSaleHistoryModel.payload?.note == ""
                              ? null
                              : detailSaleHistoryModel.payload?.note,
                          paymentMethod: "CASH",
                          status: true,
                          subTotal: detailSaleHistoryModel.payload?.subTotal,
                          tax: detailSaleHistoryModel.payload?.tax,
                          taxId: context
                              .read<CashierCubit>()
                              .taxModel
                              .payload
                              ?.first
                              .id,
                          invoiceNumber:
                              "#${detailSaleHistoryModel.payload?.invoiceNumber}",
                          purchaseds: purchaseds,
                        );

                        context
                            .read<CashierCubit>()
                            .saveOrder(orderModel: orderModel);
                        Navigator.pushNamed(context, '/main-page/payment-page')
                            .then((value) {
                          context.read<CashierCubit>().tax(
                              token: context.read<AuthCubit>().token ?? "");
                        });
                      },
                      child: Text(
                        "Bayar Sekarang",
                        style: inter.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              }
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
                var purchasedsItem = detailSaleHistoryModel
                    .payload?.invoiceItems
                    ?.map((item) => Purchaseds(
                        id: item.sellableProductId,
                        promoAmount: item.promo == null
                            ? item.price
                            : ((item.promo?.type == 'PERCENT'
                                ? (((item.price ?? 0) *
                                    (item.promo?.amount ?? 0) ~/
                                    100))
                                : (item.promoAmount ?? 0))),
                        qty: item.quantity,
                        promoId: item.promo?.id,
                        priceAll: item.resultTotal))
                    .toList();

                purchaseds?.addAll(purchasedsItem ?? []);
              }
            },
            builder: (context, state) {
              return state is DetailSaleLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : widget.paymentStatus != null
                      ? content(context
                              .read<CashierCubit>()
                              .taxModel
                              .payload
                              ?.first
                              .precentage ??
                          0)
                      : AlertDialog(
                          content: content(context
                                  .read<CashierCubit>()
                                  .taxModel
                                  .payload
                                  ?.first
                                  .precentage ??
                              0),
                        );
            },
          );
        },
      ),
    );
  }
}

class PrinterPage extends StatefulWidget {
  final DetailSaleHistoryModel detailSaleHistoryModel;
  final TaxModel taxModel;
  final bool? detailOrder;
  const PrinterPage({
    super.key,
    required this.detailSaleHistoryModel,
    required this.taxModel,
    required this.detailOrder,
  });

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  // bluetooth
  bt.BluetoothDevice? _device;
  late StreamSubscription<bool> _isScanningSubscription;
  late StreamSubscription<bt.BlueState> _blueStateSubscription;
  late StreamSubscription<bt.ConnectState> _connectStateSubscription;
  late StreamSubscription<Uint8List> _receivedDataSubscription;
  late StreamSubscription<List<bt.BluetoothDevice>> _scanResultsSubscription;
  List<bt.BluetoothDevice> _scanResults = [];

  var isPrinting = true;

  Future<void> requestBluetoothPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
  }

  _initBluetoothScan() async {
    // Step 1: Attach scanResults listener BEFORE starting scan
    _scanResultsSubscription =
        bt.BluetoothPrintPlus.scanResults.listen((event) {
      if (mounted) {
        setState(() {
          _scanResults = event;
          print("✅ Scan result received: ${_scanResults.map((e) => e.name)}");
        });
      }
    });

    /// Attach other listeners before scan (optional but clean)
    _isScanningSubscription = bt.BluetoothPrintPlus.isScanning.listen((event) {
      print('🔍 isScanning: $event');
      if (mounted) setState(() {});
    });

    _blueStateSubscription = bt.BluetoothPrintPlus.blueState.listen((event) {
      print('🔵 blueState changed: $event');
      if (mounted) setState(() {});
    });

    _connectStateSubscription =
        bt.BluetoothPrintPlus.connectState.listen((event) {
      print('🔌 connectState: $event');
      switch (event) {
        case bt.ConnectState.connected:
          setState(() {
            if (_device == null) return;
            // Navigation code here if needed
          });
          break;
        case bt.ConnectState.disconnected:
          setState(() {
            _device = null;
          });
          break;
      }
    });

    _receivedDataSubscription =
        bt.BluetoothPrintPlus.receivedData.listen((data) {
      print('📨 received data: $data');
      // handle data
    });

    // Step 2: Start the scan AFTER all listeners are attached
    print('🚀 Starting Bluetooth scan...');
    await bt.BluetoothPrintPlus.startScan(timeout: Duration(seconds: 10));
  }

  Future<void> _checkBluetoothPermission() async {
    // Check Bluetooth permission (important: adjust for Android/iOS)
    if (await Permission.bluetoothConnect.isGranted) {
      _initBluetoothScan();
    } else {
      PermissionStatus status = await Permission.bluetoothConnect.request();
      if (status.isGranted) {
        _initBluetoothScan();
      } else {
        // Permission denied — handle gracefully.
        _showPermissionDeniedDialog();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Butuh Izin Penggunaan Bluetooth",
          style: inter,
        ),
        content: Text(
          "Silahkan berikan izin penggunaan bluetooth untuk melanjutkan aktivitas ini",
          style: inter,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: inter,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initBluetoothScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 24,
            ),
            child: Text('Printer',
                style: inter.copyWith(
                  fontSize: 24,
                )),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var i = 0; i < (_scanResults.length); i++) ...{
                  GestureDetector(
                    onTap: () async {
                      await bt.BluetoothPrintPlus.connect(_scanResults[i]);
                      bt.BluetoothPrintPlus.connectState.listen((state) async {
                        print("🔌 Connection state: $state");
                        if (state == bt.ConnectState.connected) {
                          if (isPrinting == true) {
                            print("✅ Printer connected!");

                            final profile = await CapabilityProfile.load();

                            final generator =
                                Generator(PaperSize.mm58, profile);

                            List<int> bytes = [];

// Header
                            bytes += generator.text('================',
                                styles: PosStyles(align: PosAlign.center));
                            bytes += generator.text(
                              'DuitAja',
                              styles: PosStyles(
                                align: PosAlign.center,
                                bold: true,
                                height: PosTextSize.size2,
                                width: PosTextSize.size2,
                              ),
                            );
                            bytes += generator.text('================',
                                styles: PosStyles(align: PosAlign.center));
                            bytes += generator.feed(1);

// Main Details
                            bytes += generator.text(
                                "ID Pesanan: ${widget.detailSaleHistoryModel.payload?.invoiceNumber ?? '-'}");
                            bytes += generator.feed(1);

                            bytes += generator.text(
                                "Nama Pelanggan: ${widget.detailSaleHistoryModel.payload?.customerName ?? '-'}");
                            bytes += generator.feed(1);

                            String? phone = (widget.detailSaleHistoryModel
                                            .payload?.phoneNumber ??
                                        "")
                                    .isEmpty
                                ? "-"
                                : widget.detailSaleHistoryModel.payload!
                                    .phoneNumber!;
                            bytes += generator.text("No Hp: $phone");
                            bytes += generator.feed(1);

                            bytes += generator.text(
                                "Tanggal: ${widget.detailSaleHistoryModel.payload?.createdAt ?? '-'}");
                            bytes += generator.feed(1);

                            bytes += generator.text(
                                "Status: ${widget.detailSaleHistoryModel.payload?.status ?? '-'}");
                            bytes += generator.feed(1);

                            bytes += generator.text("Detail Pesanan:");
                            bytes += generator.feed(1);

// Invoice Items
                            for (var item in widget.detailSaleHistoryModel
                                    .payload?.invoiceItems ??
                                []) {
                              final priceAfterPromo = (item.price ?? 0) -
                                  ((item.promo?.type == 'PERCENT')
                                      ? ((item.price ?? 0) *
                                          (item.promoAmount ?? 0) ~/
                                          100)
                                      : (item.promoAmount ?? 0));
                              final total = item.resultTotal ?? 0;

                              // Name
                              bytes += generator.text("${item.name ?? '-'}",
                                  styles: PosStyles(align: PosAlign.left));

                              // Quantity x PriceAfterPromo
                              bytes += generator.text(
                                  "${item.quantity ?? 0} x ${formatCurrency(priceAfterPromo)}",
                                  styles: PosStyles(align: PosAlign.left));

                              // Total (right aligned)
                              bytes += generator.text(
                                  "${formatCurrency(total)}",
                                  styles: PosStyles(align: PosAlign.right));

                              bytes += generator.feed(1);
                            }

// Notes
                            String? note = (widget.detailSaleHistoryModel
                                            .payload?.note ??
                                        "")
                                    .isEmpty
                                ? "-"
                                : widget.detailSaleHistoryModel.payload!.note!;
                            bytes += generator.text("Catatan: $note");
                            bytes += generator.feed(1);

// Subtotal
                            bytes += generator.text(
                                "Sub Total: ${formatCurrency(widget.detailSaleHistoryModel.payload?.subTotal ?? 0)}");
                            bytes += generator.feed(1);

// Tax and Totals
                            if (widget.detailOrder == null) {
                              bytes += generator.text(
                                  "PPN (${widget.taxModel.payload?.first.precentage ?? 0}%): ${formatCurrency(widget.detailSaleHistoryModel.payload?.tax ?? 0)}");
                              bytes += generator.feed(1);

                              bytes += generator
                                  .text("--------------------------------");
                              bytes += generator.feed(1);

                              int total = (widget.detailSaleHistoryModel.payload
                                          ?.subTotal ??
                                      0) +
                                  (widget.detailSaleHistoryModel.payload?.tax ??
                                      0);
                              bytes += generator.text(
                                  "TOTAL: ${formatCurrency(total)}",
                                  styles: PosStyles(bold: true));
                              bytes += generator.feed(1);

                              bytes += generator
                                  .text("--------------------------------");
                              bytes += generator.feed(1);

                              bytes += generator.text(
                                  "Pembayaran (Cash): ${formatCurrency(widget.detailSaleHistoryModel.payload?.moneyReceived ?? 0)}");
                              bytes += generator.feed(1);

                              bytes += generator.text(
                                  "Kembalian: ${formatCurrency(widget.detailSaleHistoryModel.payload?.moneyBack ?? 0)}");
                              bytes += generator.feed(1);
                            }

// Footer
                            bytes += generator.feed(2);
                            bytes += generator.text('Powered by DuitAja',
                                styles: PosStyles(align: PosAlign.center));

// Cut
                            bytes += generator.cut();

// CHUNKED SENDING
                            try {
                              const chunkSize =
                                  1024; // Adjust based on printer specs
                              for (int i = 0;
                                  i < bytes.length;
                                  i += chunkSize) {
                                int end = (i + chunkSize < bytes.length)
                                    ? i + chunkSize
                                    : bytes.length;
                                await bt.BluetoothPrintPlus.write(
                                    Uint8List.fromList(bytes.sublist(i, end)));
                                await Future.delayed(Duration(
                                    milliseconds:
                                        100)); // Give the printer time to process
                              }
                            } catch (e) {
                              print("Error writing to printer: $e");
                              // Optionally show an error dialog/snackbar
                            }

                            await bt.BluetoothPrintPlus.disconnect();
                            Navigator.pop(context);
                          }

                          isPrinting = false;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        children: [
                          Text(
                            _scanResults[i].name,
                            style: inter,
                          ),
                        ],
                      ),
                    ),
                  ),
                },
              ],
            ),
          )
        ],
      ),
    );
  }
}
