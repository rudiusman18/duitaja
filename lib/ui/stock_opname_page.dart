import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:duidku/cubit/add_report_cubit.dart';
import 'package:duidku/cubit/filter_cubit.dart';
import 'package:duidku/cubit/page_cubit.dart';
import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockOpnamePage extends StatefulWidget {
  const StockOpnamePage({super.key});

  @override
  State<StockOpnamePage> createState() => _StockOpnamePageState();
}

class _StockOpnamePageState extends State<StockOpnamePage> {
  TextEditingController searchTextField = TextEditingController(text: "");

  // Digunakan ketika membuat laporan stok opname
  TextEditingController titleTextField = TextEditingController(text: "");
  TextEditingController amountTextField = TextEditingController(text: "");

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

  Widget generateStockOpnameItem({
    required String judul,
    required String numberOfStock,
    required String date,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
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
              "Sandi",
              style: inter,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];

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
      return SizedBox(
        width: 375,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            CalendarDatePicker2(
              config: config,
              value: _rangeDatePickerValueWithDefaultValue,
              onValueChanged: (dates) =>
                  setState(() => _rangeDatePickerValueWithDefaultValue = dates),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Selection(s):  '),
                const SizedBox(width: 10),
                Text(
                  _getValueText(
                    config.calendarType,
                    _rangeDatePickerValueWithDefaultValue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
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
                    context.read<PreviousPageCubit>().setPage(0);
                    context.read<PageCubit>().setPage(0);

                    var filterList = context.read<FilterCubit>().state;

                    if (context
                            .read<FilterCubit>()
                            .state[groupName]
                            ?.contains(name) ??
                        false) {
                      filterList[groupName]!.remove(name);
                      if (filterList[groupName]!.isEmpty) {
                        filterList.remove(groupName);
                      }
                    } else {
                      if (name.toLowerCase() != "semua tanggal" &&
                          name.toLowerCase() != "30 hari terakhir" &&
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
                        filterList.putIfAbsent(groupName, () => []).add(name);
                      }
                    }

                    context.read<FilterCubit>().setFilter(filterList);
                    setState(() {});
                    stateSetter(() {});
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
                      if (title.toLowerCase() == "nama") ...{
                        generateFilterContentItem(
                          groupName: title,
                          name: "Sayid",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Bambang",
                          context: context,
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Sandi",
                          context: context,
                        ),
                      } else ...{
                        generateFilterContentItem(
                          groupName: title,
                          name: "Semua Tanggal",
                          context: context,
                        ),
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
                          name: "Atur Tanggal",
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

    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
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
      );
    }

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Judul",
                                    style: inter.copyWith(fontWeight: medium),
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
                                    style: inter.copyWith(fontWeight: medium),
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
                                        amountTextField.text = value.substring(
                                            0, value.length - 1);
                                        amountTextField.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                            offset: amountTextField.text.length,
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
                                                if (titleTextField.text != "" &&
                                                    amountTextField.text !=
                                                        "") {
                                                  Navigator.pop(context);
                                                  context
                                                      .read<AddReportCubit>()
                                                      .initAddReport({
                                                    "title":
                                                        titleTextField.text,
                                                    "amount":
                                                        amountTextField.text,
                                                  });

                                                  titleTextField.text = "";
                                                  amountTextField.text = "";
                                                  Navigator.pushNamed(context,
                                                      '/main-page/stock-opname-page/add-report-page');
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
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
                          var filterList = context.read<FilterCubit>().state;
                          filterList.clear();
                          context.read<FilterCubit>().setFilter(filterList);
                          setState(() {});
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
                      groupName: "Nama",
                      title:
                          (context.read<FilterCubit>().state["Nama"]?.isEmpty ??
                                  true)
                              ? "Nama"
                              : "${context.read<FilterCubit>().state["Nama"]}"
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
              child: ListView(
            children: [
              for (var index = 0; index < 20; index++)
                generateStockOpnameItem(
                  judul: "Stok Opname November",
                  numberOfStock: "5",
                  date: "15 November 2024",
                  time: "15:28PM",
                ),
            ],
          )),
        ],
      ),
    );
  }
}
