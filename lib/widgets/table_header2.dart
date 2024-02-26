import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saraswati_pi/widgets/custom_table_cell.dart';
import 'package:saraswati_pi/widgets/dimension_button.dart';
import 'package:saraswati_pi/widgets/dimension_txt_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TableHeader extends StatefulWidget {
  final String dimension;
  const TableHeader({super.key, required this.dimension});

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  final columnWidth = {
    0: const FixedColumnWidth(35.0),
    1: const FixedColumnWidth(50.0),
    2: const FixedColumnWidth(50.0),
    3: const FixedColumnWidth(50.0),
    4: const FixedColumnWidth(50.0),
    5: const FixedColumnWidth(40.0),
    6: const FixedColumnWidth(40.0),
    7: const FixedColumnWidth(40.0),
    8: const FixedColumnWidth(50.0),
    9: const FixedColumnWidth(70.0),
  };
  final border = TableBorder.all(color: Colors.white60);
  List<Map<String, dynamic>> tableValues = [];
  List<TableRow> rows = [];
  TextEditingController actLCtrl = TextEditingController();
  TextEditingController actBCtrl = TextEditingController();
  TextEditingController thickCtrl = TextEditingController();
  TextEditingController qtyCtrl = TextEditingController();

  String dimension = "";

  double charge = 0;
  int sr = 0;
  double area = 0;
  double amount = 0;
  double actL = 0;
  double actB = 0;
  double chrL = 0;
  double chrB = 0;
  double thick = 0;
  int qty = 0;
  double rate = 0;
  int divideVal = 0;

  double getRates() {
    switch (thick) {
      case 2:
        return double.parse(rates['2mm'].toString());

      case 4:
        return double.parse(rates['4mm'].toString());

      case 5:
        return double.parse(rates['5mm'].toString());

      case 6:
        return double.parse(rates['6mm'].toString());

      case 8:
        return double.parse(rates['8mm'].toString());

      case 10:
        return double.parse(rates['10mm'].toString());

      case 12:
        return double.parse(rates['12mm'].toString());

      default:
        return 0;
    }
  }

  double onSubmit(String text) {
    String fraction = text;
    double decimal = 0;

    if (fraction.contains('/')) {
      List<String> parts = fraction.split(' ');
      if (parts.length == 2) {
        int whole = int.tryParse(parts[0]) ?? 0;
        List<String> fracParts = parts[1].split('/');
        if (fracParts.length == 2) {
          int numerator = int.tryParse(fracParts[0]) ?? 0;
          int denominator = int.tryParse(fracParts[1]) ?? 1;
          decimal = whole + numerator / denominator;
        }
      }
      return decimal;
    } else {
      decimal = double.tryParse(fraction) ?? 0.0;
      return decimal;
    }
  }

  void addRow() {
    setState(() {
      if (dimension == 'inch') {
        actL = onSubmit(actLCtrl.text);
        actB = onSubmit(actBCtrl.text);
        charge = 1.26;
        divideVal = 144;
      } else {
        actL = double.parse(actLCtrl.text);
        actB = double.parse(actBCtrl.text);
        charge = 32;
        divideVal = 92900;
      }

      thick = double.parse(thickCtrl.text);
      qty = int.parse(qtyCtrl.text);
      sr++;
      chrL = actL + charge;
      chrB = actB + charge;

      rate = getRates();
      area = double.parse(((chrL * chrB * qty) / divideVal).toStringAsFixed(2));
      amount = double.parse(
          (((chrL * chrB * qty) / divideVal) * rate).toStringAsFixed(2));
      tableValues.add({
        'sr': sr,
        'actL': actL,
        'actB': actB,
        'chrL': chrL,
        'charB': chrB,
        'thick': thick,
        'rate': rate,
        'qty': qty,
        'area': area,
        'amount': amount
      });
      rows.add(TableRow(
        children: [
          CustomTableCell(text: '$sr'),
          CustomTableCell(text: '$actL'),
          CustomTableCell(text: '$actB'),
          CustomTableCell(text: '$chrL'),
          CustomTableCell(text: '$chrB'),
          CustomTableCell(text: '$thick'),
          CustomTableCell(text: '$rate'),
          CustomTableCell(text: '$qty'),
          CustomTableCell(text: '$area'),
          CustomTableCell(text: '$amount'),
        ],
      ));
    });
  }

  void deleteRow() {
    setState(() {
      if (sr > 0) {
        sr--;
        tableValues.removeLast();
        rows.removeLast();
      }
    });
  }

  void showTotal() {
    num totalQty = 0;
    num totalAmount = 0;
    num totalArea = 0;
    for (var total in tableValues) {
      totalQty += total['qty'];
      totalAmount += total['amount'];
      totalArea += total['area'];
    }
    Alert(
      context: context,
      title: 'Calculated!',
      desc:
          'Net Price: $totalAmount\nNet Area: $totalArea\nNet Quantity: $totalQty\n',
      style: const AlertStyle(
        backgroundColor: Color(0x35EB1555),
        descStyle: TextStyle(color: Colors.white),
        titleStyle: TextStyle(color: Colors.white),
        isButtonVisible: false,
      ),
    ).show();
  }

  Map<String, Object> rates = {};

  void loadRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var ratesString = prefs.getString('rates');
    rates = Map<String, Object>.from(jsonDecode(ratesString!));
  }

  @override
  void initState() {
    dimension = widget.dimension;
    loadRates();
    super.initState();
  }

  @override
  void dispose() {
    actLCtrl.dispose();
    actBCtrl.dispose();
    thickCtrl.dispose();
    qtyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: columnWidth,
          border: border,
          children: const [
            TableRow(
              children: [
                CustomTableCell(text: ''),
                CustomTableCell(text: 'L'),
                CustomTableCell(text: 'B'),
                CustomTableCell(text: 'L'),
                CustomTableCell(text: 'B'),
                CustomTableCell(text: 'mm'),
                CustomTableCell(text: '₹/ft'),
                CustomTableCell(text: 'Nos.'),
                CustomTableCell(text: 'SQFt.'),
                CustomTableCell(text: '₹'),
              ],
            ),
          ],
        ),
        Table(
          columnWidths: columnWidth,
          border: border,
          children: rows,
        ),
        Table(
          columnWidths: columnWidth,
          border: border,
          children: [
            TableRow(
              children: [
                const TableCell(child: SizedBox()),
                DimensionTxtField(controller: actLCtrl),
                DimensionTxtField(controller: actBCtrl),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                DimensionTxtField(controller: thickCtrl),
                const TableCell(child: SizedBox()),
                DimensionTxtField(controller: qtyCtrl),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            DimensionButton(btnTxt: 'Add Row', fun: addRow),
            const SizedBox(
              width: 20,
            ),
            DimensionButton(btnTxt: 'Delete Row', fun: deleteRow),
            const SizedBox(
              width: 20,
            ),
            DimensionButton(btnTxt: 'Show Total', fun: showTotal),
          ],
        ),
      ],
    );
  }
}
