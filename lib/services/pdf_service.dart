import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<Uint8List> generatePdf(String billNo,
      List<Map<String, dynamic>> tableValues, String dimension) async {
    final pdf = pw.Document();
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
                    child: pw.Text("Bill No: $billNo",
                        style: const pw.TextStyle(fontSize: 10)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text(
                        "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: const pw.TextStyle(fontSize: 10)))),
          ],
        ));
    pw.Table tableHeader() {
      return pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(35.0),
          1: pw.FixedColumnWidth(100.0),
          2: pw.FixedColumnWidth(100.0),
          3: pw.FixedColumnWidth(40.0),
          4: pw.FixedColumnWidth(40.0),
          5: pw.FixedColumnWidth(40.0),
          6: pw.FixedColumnWidth(50.0),
          7: pw.FixedColumnWidth(70.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Sr."))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Act Size ($dimension)"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Chr Size ($dimension)"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Thick"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Rate"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Qty"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Area"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Amount"))),
            ],
          ),
        ],
      );
    }

    pw.Table table() {
      List<pw.TableRow> rows = [];
      num totalQty = 0;
      num totalAmount = 0;
      num totalArea = 0;
      for (var value in tableValues) {
        totalAmount += value["amount"];
        totalArea += value["area"];
        totalQty += value["qty"];
        rows.add(pw.TableRow(
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["sr"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["actL"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["actB"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["chrL"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["charB"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["thick"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["rate"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(value["qty"].toString()))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text(value["area"].toStringAsFixed(2)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text(value["amount"].toStringAsFixed(2)))),
          ],
        ));
      }
      return pw.Table(
        columnWidths: {
          0: const pw.FixedColumnWidth(35.0),
          1: const pw.FixedColumnWidth(50.0),
          2: const pw.FixedColumnWidth(50.0),
          3: const pw.FixedColumnWidth(50.0),
          4: const pw.FixedColumnWidth(50.0),
          5: const pw.FixedColumnWidth(40.0),
          6: const pw.FixedColumnWidth(40.0),
          7: const pw.FixedColumnWidth(40.0),
          8: const pw.FixedColumnWidth(50.0),
          9: const pw.FixedColumnWidth(70.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text(""))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("L"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("B"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("L"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("B"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("mm"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Rs./ft"))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Nos."))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("SQFt."))),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child: pw.Center(child: pw.Text("Rs."))),
            ],
          ),
          ...rows,
          pw.TableRow(children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(child: pw.Text(""))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text("TOTAL",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text(totalQty.toString(),
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text(totalArea.toStringAsFixed(2),
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Center(
                    child: pw.Text(totalAmount.toStringAsFixed(2),
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
          ]),
        ],
      );
    }

    pageWidgets.add(logoArea);
    pageWidgets.add(title);
    pageWidgets.add(title2);
    pageWidgets.add(tableHeader());
    pageWidgets.add(table());
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context content) {
          return pageWidgets;
        }));

    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    print(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
