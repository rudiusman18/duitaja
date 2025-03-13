import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:duitaja/cubit/add_report_cubit.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/filter_cubit.dart';
import 'package:duitaja/cubit/page_cubit.dart';
import 'package:duitaja/cubit/stock_opname_cubit.dart';
import 'package:duitaja/model/stock_opname_model.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StockOpnamePage extends StatefulWidget {
  const StockOpnamePage({super.key});

  @override
  State<StockOpnamePage> createState() => _StockOpnamePageState();
}

class _StockOpnamePageState extends State<StockOpnamePage> {
  StockOpnameModel? stockOpnameModel;
  int stockOpnamePage = 1;

  TextEditingController searchTextField = TextEditingController(text: "");

  // Digunakan ketika membuat laporan stok opname
  TextEditingController titleTextField = TextEditingController(text: "");
  TextEditingController amountTextField = TextEditingController(text: "");

  // ignore: no_leading_underscores_for_local_identifiers
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  bool resetDate = true;

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  bool _isLastCharInteger(String value) {
    String lastChar = value[value.length - 1];
    return int.tryParse(lastChar) != null;
  }

  @override
  void initState() {
    context.read<StockOpnameCubit>().allStockOpnameData(
        token: context.read<AuthCubit>().token ?? "",
        page: '$stockOpnamePage',
        limit: '100');
    super.initState();
  }

  Widget generateStockOpnameItem({
    required String judul,
    required String numberOfStock,
    required String changerName,
    required String createdAt,
    required int index,
  }) {
    DateTime dateTime = DateTime.parse(createdAt).toLocal();
    // Extract date and time
    String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    String time = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    return GestureDetector(
      onTap: () {
        context.read<StockOpnameDetailCubit>().setStockOpnameData(
            stockOpnameData: (stockOpnameModel?.payload?[index])!);
        Navigator.pushNamed(
            context, '/main-page/stock-opname-page/report-detail-page');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: inter.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    numberOfStock,
                    style: inter,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "$date | $time",
                    style: inter.copyWith(
                      fontWeight: medium,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_2_outlined,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              changerName,
              style: inter,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime date30DaysBefore = currentDate.subtract(const Duration(days: 30));
    DateTime date90DaysBefore = currentDate.subtract(const Duration(days: 90));
    String formattedDateNow = DateFormat('yyyy-MM-dd').format(currentDate);
    String formattedDate30 = DateFormat('yyyy-MM-dd').format(date30DaysBefore);
    String formattedDate90 = DateFormat('yyyy-MM-dd').format(date90DaysBefore);

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
                        stockOpnameModel = null;
                        stockOpnamePage = 1;
                        context.read<StockOpnameCubit>().allStockOpnameData(
                              token: context.read<AuthCubit>().token ?? "",
                              page: "$stockOpnamePage",
                              limit: '100',
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
                        if (groupName == 'Tanggal') {
                          setState(() {
                            resetDate = true;

                            _rangeDatePickerValueWithDefaultValue = [
                              DateTime.now()
                            ];
                          });
                        }
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
                        if (groupName == 'Tanggal') {
                          _rangeDatePickerValueWithDefaultValue = [
                            DateTime.now(),
                          ];
                        }
                      }
                    }
                    if (name.toLowerCase() != 'atur tanggal') {
                      context.read<FilterCubit>().setFilter(filterList);
                      setState(() {});
                      stateSetter(() {});
                      Navigator.pop(context);
                      stockOpnameModel = null;
                      stockOpnamePage = 1;
                      context.read<StockOpnameCubit>().allStockOpnameData(
                            token: context.read<AuthCubit>().token ?? "",
                            page: "$stockOpnamePage",
                            limit: '100',
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
                        name: _rangeDatePickerValueWithDefaultValue.length == 1
                            ? "Atur Tanggal"
                            : "${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.first ?? DateTime.now())} - ${DateFormat('yyyy-MM-dd').format(_rangeDatePickerValueWithDefaultValue.last ?? DateTime.now())}",
                        context: context,
                      ),
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

    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: TextFormField(
          controller: searchTextField,
          textInputAction: TextInputAction.search,
          onChanged: (text) {
            if (text == "") {
              stockOpnameModel = null;
              stockOpnamePage = 1;
              context.read<StockOpnameCubit>().allStockOpnameData(
                    token: context.read<AuthCubit>().token ?? "",
                    page: "$stockOpnamePage",
                    limit: '100',
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
                    search: text,
                  );
            }
          },
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
            stockOpnameModel = null;
            stockOpnamePage = 1;
            stockOpnameModel = null;
            stockOpnamePage = 1;
            context.read<StockOpnameCubit>().allStockOpnameData(
                  token: context.read<AuthCubit>().token ?? "",
                  page: "$stockOpnamePage",
                  limit: '100',
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
      );
    }

    return BlocConsumer<StockOpnameCubit, StockOpnameState>(
      listener: (context, state) {
        if (state is StockOpnameTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }

        if (state is StockOpnameSuccess) {
          if (stockOpnameModel == null) {
            stockOpnameModel = state.stockOpnameData;
          } else {
            stockOpnameModel?.payload
                ?.addAll(state.stockOpnameData.payload?.toList() ?? []);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Stok Opname",
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
          body: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: searchSetup(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      titleTextField.text = "";
                                      amountTextField.text = "";
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Judul",
                                        style:
                                            inter.copyWith(fontWeight: medium),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: titleTextField,
                                        decoration: InputDecoration(
                                          hintText: "Masukkan Judul",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        "Jumlah Produk",
                                        style:
                                            inter.copyWith(fontWeight: medium),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: amountTextField,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.isNotEmpty &&
                                              !_isLastCharInteger(value)) {
                                            // Remove the last character if it's not an integer
                                            amountTextField.text = value
                                                .substring(0, value.length - 1);
                                            amountTextField.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                    amountTextField.text.length,
                                              ),
                                            );
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Masukkan Jumlah Produk",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                              width: 2.0,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 45,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 136,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    if (titleTextField.text !=
                                                            "" &&
                                                        amountTextField.text !=
                                                            "") {
                                                      Navigator.pop(context);
                                                      context
                                                          .read<
                                                              AddReportCubit>()
                                                          .initAddReport({
                                                        "title":
                                                            titleTextField.text,
                                                        "amount":
                                                            amountTextField
                                                                .text,
                                                      });

                                                      titleTextField.text = "";
                                                      amountTextField.text = "";
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/main-page/stock-opname-page/add-report-page');
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        primaryColor,
                                                  ),
                                                  child: Text(
                                                    "Lanjut",
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
                                ],
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: Text(
                      "Buat",
                      style: inter.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
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
                              context.read<FilterCubit>().setFilter(filterList);
                              stockOpnameModel = null;
                              stockOpnamePage = 1;
                              setState(() {
                                resetDate = true;
                              });
                              context
                                  .read<StockOpnameCubit>()
                                  .allStockOpnameData(
                                    token:
                                        context.read<AuthCubit>().token ?? "",
                                    page: '$stockOpnamePage',
                                    limit: '100',
                                    search: searchTextField.text,
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
                        // generateFilterItem(
                        //   groupName: "Nama",
                        //   title: (context
                        //               .read<FilterCubit>()
                        //               .state["Nama"]
                        //               ?.isEmpty ??
                        //           true)
                        //       ? "Nama"
                        //       : "${context.read<FilterCubit>().state["Nama"]}"
                        //           .replaceAll("[", "")
                        //           .replaceAll("]", ""),
                        // ),
                        // const SizedBox(
                        //   width: 24,
                        // ),
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
                  if (stockOpnamePage <
                      (stockOpnameModel?.meta?.totalPage ?? 0)) {
                    stockOpnamePage += 1;
                    context.read<StockOpnameCubit>().allStockOpnameData(
                        token: context.read<AuthCubit>().token ?? "",
                        page: '$stockOpnamePage',
                        limit: '100');
                  }
                  return true;
                },
                child: state is StockOpnameLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : state is StockOpnameFailure || stockOpnameModel == null
                        ? Center(
                            child: Text(
                              "Data tidak ditemukan",
                              style: inter,
                            ),
                          )
                        : ListView(
                            children: [
                              for (var index = 0;
                                  index <
                                      (stockOpnameModel?.payload?.length ?? 0);
                                  index++)
                                generateStockOpnameItem(
                                  index: index,
                                  judul:
                                      "${stockOpnameModel?.payload?[index].title}",
                                  numberOfStock:
                                      "${stockOpnameModel?.payload?[index].amount} Produk",
                                  createdAt:
                                      "${stockOpnameModel?.payload?[index].createdAt}",
                                  changerName:
                                      "${stockOpnameModel?.payload?[index].changerName}",
                                ),
                            ],
                          ),
              )),
            ],
          ),
        );
      },
    );
  }
}
