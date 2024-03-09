import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

class PdfService {
  Future<Uint8List> generatePdf(String billName,
      List<Map<String, dynamic>> tableValues, String dimension) async {
    Map<String, Object> rates = {
      '2mm': 1,
      '3mm': 1,
      '3.5mm': 1,
      '4mm': 1,
      '5mm': 1,
      '6mm': 1,
      '8mm': 1,
      '10mm': 1,
      '12mm': 1,
      'holes': 1,
      'cnt': 1,
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var ratesString = prefs.getString('rates');
    rates = Map<String, Object>.from(jsonDecode(ratesString!));

    final pdf = pw.Document();
    num totalQty = 0;
    num totalAmount = 0;
    num adminCharges = 200;
    num totalArea = 0;
    num totalHoles = 0;
    num totalCnt = 0;
    num holesChr = 0;
    num cntChr = 0;
    List<pw.Widget> pageWidgets = [];
    final logo =
        (await rootBundle.load("images/logo.png")).buffer.asUint8List();
    final logoArea = pw.Container(
        height: 60,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        padding: const pw.EdgeInsets.all(2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
                padding: const pw.EdgeInsets.only(right: 2),
                decoration: const pw.BoxDecoration(
                    border: pw.Border(right: pw.BorderSide())),
                child: pw.Image(pw.MemoryImage(logo))),
            pw.Expanded(
                child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      children: [
                        pw.Expanded(
                            child: pw.Text("Saraswati Enterprises",
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold))),
                        pw.SizedBox(height: 20),
                        pw.Expanded(
                            child: pw.Text(
                                "Address: Plot no. P-13, SUPA MIDC, Tal. Parner, Dist. Ahmednagar, Pincode: 414301",
                                style: const pw.TextStyle(fontSize: 8))),
                        pw.SizedBox(height: 5),
                        pw.Expanded(
                            child: pw.Text(
                                "Mob: 9763572001 | Email: amol.2013.at@gmail.com",
                                style: const pw.TextStyle(fontSize: 8))),
                      ],
                    ))),
          ],
        ));
    final title = pw.Container(
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                right: pw.BorderSide(),
                left: pw.BorderSide(),
                bottom: pw.BorderSide())),
        child: pw.Center(
            child: pw.Text("PROFORMA INVOICE",
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold))));
    final title2 = pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text("Customer Name: $billName",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text(
                        "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: const pw.TextStyle(fontSize: 10)))),
          ],
        ));
    pw.Padding blankCell() {
      return pw.Padding(padding: const pw.EdgeInsets.all(2));
    }

    pw.Padding textCell(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(child: pw.Text(text)));
    }

    pw.Padding textCellBold(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(
              child: pw.Text(text,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    }

    pw.Table tableHeader() {
      return pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(25.0),
          1: pw.FixedColumnWidth(100.0),
          2: pw.FixedColumnWidth(100.0),
          3: pw.FixedColumnWidth(40.0),
          4: pw.FixedColumnWidth(40.0),
          5: pw.FixedColumnWidth(40.0),
          6: pw.FixedColumnWidth(40.0),
          7: pw.FixedColumnWidth(40.0),
          8: pw.FixedColumnWidth(50.0),
          9: pw.FixedColumnWidth(70.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              textCellBold("Sr"),
              textCellBold("Act Size ($dimension)"),
              textCellBold("Chr Size ($dimension)"),
              textCellBold("Thick"),
              textCellBold("Rate"),
              textCellBold("Qty"),
              textCellBold("HOL"),
              textCellBold("CNT"),
              textCellBold("Area"),
              textCellBold("Amount"),
            ],
          ),
        ],
      );
    }

    pw.Table table() {
      List<pw.TableRow> rows = [];
      for (var value in tableValues) {
        totalAmount += value["amount"];
        totalArea += value["area"];
        totalQty += value["qty"];
        totalHoles += value["holes"];
        totalCnt += value["cnt"];
        holesChr = totalHoles * (double.parse(rates['holes'].toString()));
        cntChr = totalCnt * (double.parse(rates['cnt'].toString()));
        rows.add(pw.TableRow(
          children: [
            textCell(value["sr"].toString()),
            textCell(value["actL"].toString()),
            textCell(value["actB"].toString()),
            textCell(value["chrL"].toString()),
            textCell(value["charB"].toString()),
            textCell(value["thick"].toString()),
            textCell(value["rate"].toString()),
            textCell(value["qty"].toString()),
            textCell(value["holes"].toString()),
            textCell(value["cnt"].toString()),
            textCell(value["area"].toStringAsFixed(2)),
            textCell(value["amount"].toStringAsFixed(2)),
          ],
        ));
      }
      return pw.Table(
        columnWidths: {
          0: const pw.FixedColumnWidth(25.0),
          1: const pw.FixedColumnWidth(50.0),
          2: const pw.FixedColumnWidth(50.0),
          3: const pw.FixedColumnWidth(50.0),
          4: const pw.FixedColumnWidth(50.0),
          5: const pw.FixedColumnWidth(40.0),
          6: const pw.FixedColumnWidth(40.0),
          7: const pw.FixedColumnWidth(40.0),
          8: const pw.FixedColumnWidth(40.0),
          9: const pw.FixedColumnWidth(40.0),
          10: const pw.FixedColumnWidth(50.0),
          11: const pw.FixedColumnWidth(70.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              blankCell(),
              textCell("L"),
              textCell("B"),
              textCell("L"),
              textCell("B"),
              textCell("mm"),
              textCell("Rs./ft"),
              textCell("Nos."),
              textCell("Nos."),
              textCell("Nos."),
              textCell("SQFt."),
              textCell("Rs."),
            ],
          ),
          ...rows,
          pw.TableRow(children: [
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            textCellBold("TTL"),
            textCellBold(totalQty.toString()),
            textCellBold(totalHoles.toString()),
            textCellBold(totalCnt.toString()),
            textCellBold(totalArea.toStringAsFixed(2)),
            blankCell(),
          ]),
        ],
      );
    }

    pw.Table tableFooter() {
      num totBeforeTax = totalAmount + adminCharges + holesChr + cntChr;
      num taxAmt = 0.09 * totBeforeTax;
      num grandTotal = totBeforeTax + (2 * taxAmt);
      return pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(90.0),
          1: pw.FixedColumnWidth(160.0),
          2: pw.FixedColumnWidth(145.0),
          3: pw.FixedColumnWidth(60.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              blankCell(),
              blankCell(),
              textCellBold("SUB TOTAL"),
              textCellBold(totalAmount.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("GST NO:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("27AVHPT6781H1ZW",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              textCell("ADMIN CHARGES"),
              textCell(adminCharges.toString()),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("A/C Name:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("SARASWATI ENTERPRISES")),
              textCell("HOLES CHARGES"),
              textCell(holesChr.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("A/C Number:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("758805000007",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              textCell("CUTOUT CHARGES"),
              textCell(cntChr.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("A/C TYPE:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("CURRENT ACCOUNT")),
              textCellBold("TOTAL BEFORE TAX"),
              textCellBold(totBeforeTax.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("BRANCH:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("ICICI BANK")),
              textCell("CGST @ 9%"),
              textCell(taxAmt.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("IFSC CODE:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("ICIC0007588")),
              textCell("SGST @ 9%"),
              textCell(taxAmt.toStringAsFixed(2)),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Text("PAYMENT:",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              blankCell(),
              textCellBold("GRAND TOTAL"),
              textCellBold(grandTotal.toStringAsFixed(2)),
            ],
          ),
        ],
      );
    }

    pageWidgets.add(logoArea);
    pageWidgets.add(title);
    pageWidgets.add(title2);
    pageWidgets.add(tableHeader());
    pageWidgets.add(table());
    pageWidgets.add(tableFooter());

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        build: (pw.Context content) {
          return pageWidgets;
        }));

    return pdf.save();
  }
}
