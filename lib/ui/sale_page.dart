import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/filter_cubit.dart';
import 'package:duitaja/cubit/page_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/model/sale_history_model.dart';
import 'package:duitaja/shared/sale_detail_page.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SalePage extends StatefulWidget {
  bool clearFilterCubit = false;
  SalePage({super.key, required this.clearFilterCubit});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  TextEditingController searchTextField = TextEditingController(text: "");

  int saleProductPage = 1;
  SaleHistoryModel? saleHistoryModel;

  // ignore: no_leading_underscores_for_local_identifiers
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  bool resetDate = true;

  @override
  void initState() {
    context.read<SaleCubit>().allSalesHistory(
          token: context.read<AuthCubit>().token ?? "",
          page: "$saleProductPage",
          limit: "100",
          status: '',
          startDate: "",
          endDate: "",
          search: "",
          inStatus: "",
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime date30DaysBefore = currentDate.subtract(const Duration(days: 30));
    DateTime date90DaysBefore = currentDate.subtract(const Duration(days: 90));
    String formattedDateNow = DateFormat('yyyy-MM-dd').format(currentDate);
    String formattedDate30 = DateFormat('yyyy-MM-dd').format(date30DaysBefore);
    String formattedDate90 = DateFormat('yyyy-MM-dd').format(date90DaysBefore);

    if (widget.clearFilterCubit == true) {
      final _ = context.read<FilterCubit>().setFilter({});
      widget.clearFilterCubit = false;
    }

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
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  if (value == "") {
                    print(
                        "asw ${context.read<FilterCubit>().state['Tanggal']}");
                    saleHistoryModel = null;
                    saleProductPage = 1;
                    context.read<SaleCubit>().allSalesHistory(
                          token: context.read<AuthCubit>().token ?? "",
                          page: "$saleProductPage",
                          limit: '100',
                          status: '',
                          startDate: resetDate
                              ? ''
                              : context
                                          .read<FilterCubit>()
                                          .state['Tanggal']
                                          ?.first
                                          .toLowerCase() ==
                                      '30 hari terakhir'
                                  ? formattedDate30
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '90 hari terakhir'
                                      ? formattedDate90
                                      : DateFormat('yyyy-MM-dd').format(
                                          _rangeDatePickerValueWithDefaultValue
                                                  .first ??
                                              DateTime.now()),
                          endDate: resetDate
                              ? ''
                              : context
                                          .read<FilterCubit>()
                                          .state['Tanggal']
                                          ?.first
                                          .toLowerCase() ==
                                      '30 hari terakhir'
                                  ? formattedDateNow
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '90 hari terakhir'
                                      ? formattedDateNow
                                      : DateFormat('yyyy-MM-dd').format(
                                          _rangeDatePickerValueWithDefaultValue
                                                  .last ??
                                              DateTime.now()),
                          search: searchTextField.text,
                          inStatus: context
                                      .read<FilterCubit>()
                                      .state['Status']
                                      ?.first
                                      .toLowerCase() ==
                                  "lunas"
                              ? 'paid'
                              : context
                                          .read<FilterCubit>()
                                          .state['Status']
                                          ?.first
                                          .toLowerCase() ==
                                      'belum lunas'
                                  ? 'unpaid'
                                  : context
                                              .read<FilterCubit>()
                                              .state['Status']
                                              ?.first
                                              .toLowerCase() ==
                                          'refund'
                                      ? 'refund'
                                      : '',
                        );
                  }
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  saleHistoryModel = null;
                  saleProductPage = 1;
                  context.read<SaleCubit>().allSalesHistory(
                        token: context.read<AuthCubit>().token ?? "",
                        page: "$saleProductPage",
                        limit: '100',
                        status: '',
                        startDate: resetDate
                            ? ''
                            : context
                                        .read<FilterCubit>()
                                        .state['Tanggal']
                                        ?.first
                                        .toLowerCase() ==
                                    '30 hari terakhir'
                                ? formattedDate30
                                : context
                                            .read<FilterCubit>()
                                            .state['Tanggal']
                                            ?.first
                                            .toLowerCase() ==
                                        '90 hari terakhir'
                                    ? formattedDate90
                                    : DateFormat('yyyy-MM-dd').format(
                                        _rangeDatePickerValueWithDefaultValue
                                                .first ??
                                            DateTime.now()),
                        endDate: resetDate
                            ? ''
                            : context
                                        .read<FilterCubit>()
                                        .state['Tanggal']
                                        ?.first
                                        .toLowerCase() ==
                                    '30 hari terakhir'
                                ? formattedDateNow
                                : context
                                            .read<FilterCubit>()
                                            .state['Tanggal']
                                            ?.first
                                            .toLowerCase() ==
                                        '90 hari terakhir'
                                    ? formattedDateNow
                                    : DateFormat('yyyy-MM-dd').format(
                                        _rangeDatePickerValueWithDefaultValue
                                                .last ??
                                            DateTime.now()),
                        search: searchTextField.text,
                        inStatus: context
                                    .read<FilterCubit>()
                                    .state['Status']
                                    ?.first
                                    .toLowerCase() ==
                                "lunas"
                            ? 'paid'
                            : context
                                        .read<FilterCubit>()
                                        .state['Status']
                                        ?.first
                                        .toLowerCase() ==
                                    'belum lunas'
                                ? 'unpaid'
                                : context
                                            .read<FilterCubit>()
                                            .state['Status']
                                            ?.first
                                            .toLowerCase() ==
                                        'refund'
                                    ? 'refund'
                                    : '',
                      );
                },
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

    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildRangeDatePickerWithValue() {
      final config = CalendarDatePicker2Config(
        centerAlignModePicker: true,
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: primaryColor,
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        controlsTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        dynamicCalendarRows: true,
        weekdayLabels: ["Mi", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"],
        disabledDayTextStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      );
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter2) {
          return SizedBox(
            width: 375,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                CalendarDatePicker2(
                  config: config,
                  value: _rangeDatePickerValueWithDefaultValue,
                  onValueChanged: (dates) {
                    stateSetter2(() {
                      _rangeDatePickerValueWithDefaultValue = dates;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        setState(() {
                          resetDate = false;
                        });
                        var data = context.read<FilterCubit>().state;
                        if (data['Tanggal'] != null) {
                          data['Tanggal'] = [
                            '${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.first ?? DateTime.now())} - ${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.last ?? DateTime.now())}'
                          ];
                        } else {
                          data.addAll({
                            'Tanggal': [
                              '${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.first ?? DateTime.now())} - ${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.last ?? DateTime.now())}'
                            ]
                          });
                        }
                        context.read<FilterCubit>().setFilter(data);
                        saleHistoryModel = null;
                        saleProductPage = 1;
                        context.read<SaleCubit>().allSalesHistory(
                              token: context.read<AuthCubit>().token ?? "",
                              page: "$saleProductPage",
                              limit: '100',
                              status: '',
                              startDate: resetDate
                                  ? ''
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '30 hari terakhir'
                                      ? formattedDate30
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Tanggal']
                                                  ?.first
                                                  .toLowerCase() ==
                                              '90 hari terakhir'
                                          ? formattedDate90
                                          : DateFormat('yyyy-MM-dd').format(
                                              _rangeDatePickerValueWithDefaultValue
                                                      .first ??
                                                  DateTime.now()),
                              endDate: resetDate
                                  ? ''
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '30 hari terakhir'
                                      ? formattedDateNow
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Tanggal']
                                                  ?.first
                                                  .toLowerCase() ==
                                              '90 hari terakhir'
                                          ? formattedDateNow
                                          : DateFormat('yyyy-MM-dd').format(
                                              _rangeDatePickerValueWithDefaultValue
                                                      .last ??
                                                  DateTime.now()),
                              search: searchTextField.text,
                              inStatus: context
                                          .read<FilterCubit>()
                                          .state['Status']
                                          ?.first
                                          .toLowerCase() ==
                                      "lunas"
                                  ? 'paid'
                                  : context
                                              .read<FilterCubit>()
                                              .state['Status']
                                              ?.first
                                              .toLowerCase() ==
                                          'belum lunas'
                                      ? 'unpaid'
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Status']
                                                  ?.first
                                                  .toLowerCase() ==
                                              'refund'
                                          ? 'refund'
                                          : '',
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      child: Text(
                        "Simpan",
                        style: inter,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    }

    Widget generateFilterContentItem({
      required BuildContext context,
      required String groupName,
      required String name,
    }) {
      return StatefulBuilder(
        builder: (context, stateSetter) {
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
                child: GestureDetector(
                  onTap: () {
                    context.read<PreviousPageCubit>().setPage(2);
                    context.read<PageCubit>().setPage(2);

                    var filterList = context.read<FilterCubit>().state;

                    if (groupName == 'Tanggal') {
                      setState(() {
                        resetDate = false;
                      });
                    }

                    if (context
                            .read<FilterCubit>()
                            .state[groupName]
                            ?.contains(name) ??
                        false) {
                      filterList[groupName]!.remove(name);
                      if (filterList[groupName]!.isEmpty) {
                        filterList.remove(groupName);
                        setState(() {
                          resetDate = true;
                        });
                        _rangeDatePickerValueWithDefaultValue = [
                          DateTime.now()
                        ];
                      }
                    } else {
                      if (name.toLowerCase() != "30 hari terakhir" &&
                          name.toLowerCase() != "90 hari terakhir" &&
                          groupName.toLowerCase() == "tanggal") {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            isScrollControlled:
                                true, // To make the sheet adjustable for larger content
                            builder: (context) {
                              return _buildRangeDatePickerWithValue();
                            });
                      } else {
                        filterList.putIfAbsent(groupName, () => []).clear();
                        filterList.putIfAbsent(groupName, () => []).add(name);
                        _rangeDatePickerValueWithDefaultValue = [
                          DateTime.now(),
                        ];
                      }
                    }
                    if (name.toLowerCase() != 'atur tanggal') {
                      context.read<FilterCubit>().setFilter(filterList);
                      setState(() {});
                      stateSetter(() {});
                      Navigator.pop(context);
                      saleHistoryModel = null;
                      saleProductPage = 1;
                      context.read<SaleCubit>().allSalesHistory(
                            token: context.read<AuthCubit>().token ?? "",
                            page: "$saleProductPage",
                            limit: '100',
                            status: '',
                            startDate: resetDate
                                ? ''
                                : context
                                            .read<FilterCubit>()
                                            .state['Tanggal']
                                            ?.first
                                            .toLowerCase() ==
                                        '30 hari terakhir'
                                    ? formattedDate30
                                    : context
                                                .read<FilterCubit>()
                                                .state['Tanggal']
                                                ?.first
                                                .toLowerCase() ==
                                            '90 hari terakhir'
                                        ? formattedDate90
                                        : DateFormat('yyyy-MM-dd').format(
                                            _rangeDatePickerValueWithDefaultValue
                                                    .first ??
                                                DateTime.now()),
                            endDate: resetDate
                                ? ''
                                : context
                                            .read<FilterCubit>()
                                            .state['Tanggal']
                                            ?.first
                                            .toLowerCase() ==
                                        '30 hari terakhir'
                                    ? formattedDateNow
                                    : context
                                                .read<FilterCubit>()
                                                .state['Tanggal']
                                                ?.first
                                                .toLowerCase() ==
                                            '90 hari terakhir'
                                        ? formattedDateNow
                                        : DateFormat('yyyy-MM-dd').format(
                                            _rangeDatePickerValueWithDefaultValue
                                                    .last ??
                                                DateTime.now()),
                            search: searchTextField.text,
                            inStatus: context
                                        .read<FilterCubit>()
                                        .state['Status']
                                        ?.first
                                        .toLowerCase() ==
                                    "lunas"
                                ? 'paid'
                                : context
                                            .read<FilterCubit>()
                                            .state['Status']
                                            ?.first
                                            .toLowerCase() ==
                                        'belum lunas'
                                    ? 'unpaid'
                                    : context
                                                .read<FilterCubit>()
                                                .state['Status']
                                                ?.first
                                                .toLowerCase() ==
                                            'refund'
                                        ? 'refund'
                                        : '',
                          );
                    }
                  },
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
                          color: (context
                                      .read<FilterCubit>()
                                      .state[groupName]
                                      ?.contains(name) ??
                                  false)
                              ? primaryColor
                              : greyColor1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: (context
                                    .read<FilterCubit>()
                                    .state[groupName]
                                    ?.contains(name) ??
                                false)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
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
        },
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
                        generateFilterContentItem(
                          groupName: title,
                          name: "Kasir",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Tokopedia",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "TiktokShop",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Shopee",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "GoFood",
                          context: context,
                        ),
                      } else if (title.toLowerCase() == "status") ...{
                        generateFilterContentItem(
                          groupName: title,
                          name: "Lunas",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Belum Lunas",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Refund",
                          context: context,
                        ),
                      } else ...{
                        generateFilterContentItem(
                          groupName: title,
                          name: "30 Hari Terakhir",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "90 Hari Terakhir",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: _rangeDatePickerValueWithDefaultValue.length ==
                                  1
                              ? "Atur Tanggal"
                              : "${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.first ?? DateTime.now())} - ${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.last ?? DateTime.now())}",
                          context: context,
                        ),
                      },
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget generateFilterItem(
        {required String groupName, required String title}) {
      return GestureDetector(
        onTap: () {
          _showBottomSheet(
            context,
            title: groupName,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color:
                (context.read<FilterCubit>().state[groupName]?.isEmpty ?? true)
                    ? Colors.transparent
                    : primaryColor,
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
                  color:
                      (context.read<FilterCubit>().state[groupName]?.isEmpty ??
                              true)
                          ? primaryColor
                          : Colors.white,
                  fontWeight: medium,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: (context.read<FilterCubit>().state[groupName]?.isEmpty ??
                        true)
                    ? disableColor
                    : Colors.white,
              )
            ],
          ),
        ),
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
              }).then((_) {
            saleHistoryModel = null;
            saleProductPage = 1;
            context.read<SaleCubit>().allSalesHistory(
                  token: context.read<AuthCubit>().token ?? "",
                  page: "$saleProductPage",
                  limit: '100',
                  status: '',
                  startDate: resetDate
                      ? ''
                      : context
                                  .read<FilterCubit>()
                                  .state['Tanggal']
                                  ?.first
                                  .toLowerCase() ==
                              '30 hari terakhir'
                          ? formattedDate30
                          : context
                                      .read<FilterCubit>()
                                      .state['Tanggal']
                                      ?.first
                                      .toLowerCase() ==
                                  '90 hari terakhir'
                              ? formattedDate90
                              : DateFormat('yyyy-MM-dd').format(
                                  _rangeDatePickerValueWithDefaultValue.first ??
                                      DateTime.now()),
                  endDate: resetDate
                      ? ''
                      : context
                                  .read<FilterCubit>()
                                  .state['Tanggal']
                                  ?.first
                                  .toLowerCase() ==
                              '30 hari terakhir'
                          ? formattedDateNow
                          : context
                                      .read<FilterCubit>()
                                      .state['Tanggal']
                                      ?.first
                                      .toLowerCase() ==
                                  '90 hari terakhir'
                              ? formattedDateNow
                              : DateFormat('yyyy-MM-dd').format(
                                  _rangeDatePickerValueWithDefaultValue.last ??
                                      DateTime.now()),
                  search: searchTextField.text,
                  inStatus: context
                              .read<FilterCubit>()
                              .state['Status']
                              ?.first
                              .toLowerCase() ==
                          "lunas"
                      ? 'paid'
                      : context
                                  .read<FilterCubit>()
                                  .state['Status']
                                  ?.first
                                  .toLowerCase() ==
                              'belum lunas'
                          ? 'unpaid'
                          : context
                                      .read<FilterCubit>()
                                      .state['Status']
                                      ?.first
                                      .toLowerCase() ==
                                  'refund'
                              ? 'refund'
                              : '',
                );
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
        if (state is SaleSuccess) {
          if (saleHistoryModel == null) {
            saleHistoryModel = context.read<SaleCubit>().saleHistoryModel;
          } else {
            saleHistoryModel?.payload?.addAll(
                context.read<SaleCubit>().saleHistoryModel.payload?.toList() ??
                    []);
          }
        }
        if (state is SaleTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      builder: (context, state) {
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
                          if (context.read<FilterCubit>().state.isNotEmpty) ...{
                            GestureDetector(
                              onTap: () {
                                _rangeDatePickerValueWithDefaultValue = [
                                  DateTime.now(),
                                ];
                                var filterList =
                                    context.read<FilterCubit>().state;
                                filterList.clear();
                                context
                                    .read<FilterCubit>()
                                    .setFilter(filterList);
                                setState(() {
                                  resetDate = true;
                                });
                                saleHistoryModel = null;
                                saleProductPage = 1;
                                context.read<SaleCubit>().allSalesHistory(
                                      token:
                                          context.read<AuthCubit>().token ?? "",
                                      page: "$saleProductPage",
                                      limit: '100',
                                      status: '',
                                      startDate: resetDate
                                          ? ''
                                          : context
                                                      .read<FilterCubit>()
                                                      .state['Tanggal']
                                                      ?.first
                                                      .toLowerCase() ==
                                                  '30 hari terakhir'
                                              ? formattedDate30
                                              : context
                                                          .read<FilterCubit>()
                                                          .state['Tanggal']
                                                          ?.first
                                                          .toLowerCase() ==
                                                      '90 hari terakhir'
                                                  ? formattedDate90
                                                  : DateFormat('yyyy-MM-dd').format(
                                                      _rangeDatePickerValueWithDefaultValue
                                                              .first ??
                                                          DateTime.now()),
                                      endDate: resetDate
                                          ? ''
                                          : context
                                                      .read<FilterCubit>()
                                                      .state['Tanggal']
                                                      ?.first
                                                      .toLowerCase() ==
                                                  '30 hari terakhir'
                                              ? formattedDateNow
                                              : context
                                                          .read<FilterCubit>()
                                                          .state['Tanggal']
                                                          ?.first
                                                          .toLowerCase() ==
                                                      '90 hari terakhir'
                                                  ? formattedDateNow
                                                  : DateFormat('yyyy-MM-dd').format(
                                                      _rangeDatePickerValueWithDefaultValue
                                                              .last ??
                                                          DateTime.now()),
                                      search: searchTextField.text,
                                      inStatus: context
                                                  .read<FilterCubit>()
                                                  .state['Status']
                                                  ?.first
                                                  .toLowerCase() ==
                                              "lunas"
                                          ? 'paid'
                                          : context
                                                      .read<FilterCubit>()
                                                      .state['Status']
                                                      ?.first
                                                      .toLowerCase() ==
                                                  'belum lunas'
                                              ? 'unpaid'
                                              : context
                                                          .read<FilterCubit>()
                                                          .state['Status']
                                                          ?.first
                                                          .toLowerCase() ==
                                                      'refund'
                                                  ? 'refund'
                                                  : '',
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(
                                  6,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                          },
                          generateFilterItem(
                            groupName: "Penjualan",
                            title: (context
                                        .read<FilterCubit>()
                                        .state["Penjualan"]
                                        ?.isEmpty ??
                                    true)
                                ? "Penjualan"
                                : "${context.read<FilterCubit>().state["Penjualan"]}"
                                    .replaceAll("[", "")
                                    .replaceAll("]", ""),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          generateFilterItem(
                            groupName: "Status",
                            title: (context
                                        .read<FilterCubit>()
                                        .state["Status"]
                                        ?.isEmpty ??
                                    true)
                                ? "Status"
                                : "${context.read<FilterCubit>().state["Status"]}"
                                    .replaceAll("[", "")
                                    .replaceAll("]", ""),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          generateFilterItem(
                            groupName: "Tanggal",
                            title: (context
                                        .read<FilterCubit>()
                                        .state["Tanggal"]
                                        ?.isEmpty ??
                                    true)
                                ? "Tanggal"
                                : "${context.read<FilterCubit>().state["Tanggal"]}"
                                    .replaceAll("[", "")
                                    .replaceAll("]", ""),
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
                  child: NotificationListener(
                    onNotification: (ScrollEndNotification notification) {
                      if (saleProductPage !=
                          context
                              .read<SaleCubit>()
                              .saleHistoryModel
                              .meta
                              ?.totalPage) {
                        saleProductPage += 1;
                        context.read<SaleCubit>().allSalesHistory(
                              token: context.read<AuthCubit>().token ?? "",
                              page: "$saleProductPage",
                              limit: '100',
                              status: '',
                              startDate: resetDate
                                  ? ''
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '30 hari terakhir'
                                      ? formattedDate30
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Tanggal']
                                                  ?.first
                                                  .toLowerCase() ==
                                              '90 hari terakhir'
                                          ? formattedDate90
                                          : DateFormat('yyyy-MM-dd').format(
                                              _rangeDatePickerValueWithDefaultValue
                                                      .first ??
                                                  DateTime.now()),
                              endDate: resetDate
                                  ? ''
                                  : context
                                              .read<FilterCubit>()
                                              .state['Tanggal']
                                              ?.first
                                              .toLowerCase() ==
                                          '30 hari terakhir'
                                      ? formattedDateNow
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Tanggal']
                                                  ?.first
                                                  .toLowerCase() ==
                                              '90 hari terakhir'
                                          ? formattedDateNow
                                          : DateFormat('yyyy-MM-dd').format(
                                              _rangeDatePickerValueWithDefaultValue
                                                      .last ??
                                                  DateTime.now()),
                              search: searchTextField.text,
                              inStatus: context
                                          .read<FilterCubit>()
                                          .state['Status']
                                          ?.first
                                          .toLowerCase() ==
                                      "lunas"
                                  ? 'paid'
                                  : context
                                              .read<FilterCubit>()
                                              .state['Status']
                                              ?.first
                                              .toLowerCase() ==
                                          'belum lunas'
                                      ? 'unpaid'
                                      : context
                                                  .read<FilterCubit>()
                                                  .state['Status']
                                                  ?.first
                                                  .toLowerCase() ==
                                              'refund'
                                          ? 'refund'
                                          : '',
                            );
                      }
                      return true;
                    },
                    child: state is SaleLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : (saleHistoryModel?.payload?.isEmpty ?? true)
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
                                          (saleHistoryModel?.payload?.length ??
                                              0);
                                      i++)
                                    generateSalesHistoryItem(
                                      payloadId:
                                          "${saleHistoryModel?.payload?[i].id}",
                                      buyerName:
                                          "${saleHistoryModel?.payload?[i].customerName}",
                                      orderAmount:
                                          "${saleHistoryModel?.payload?[i].countSale}",
                                      date:
                                          "${saleHistoryModel?.payload?[i].createdAt?.split(" ").first}",
                                      time:
                                          "${saleHistoryModel?.payload?[i].createdAt?.split(" ").last}",
                                      status:
                                          "${saleHistoryModel?.payload?[i].status}",
                                      price: formatCurrency(saleHistoryModel
                                              ?.payload?[i].subTotal ??
                                          0),
                                    ),
                                ],
                              ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
