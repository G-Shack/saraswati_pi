import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/custom_table_cell.dart';

class TableTemplate extends StatelessWidget {
  final String dimension;
  const TableTemplate({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    getColumnWidth() {
      if (screenWidth < 450) {
        double multiFactor = 565 / screenWidth;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(84.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(42.0 * multiFactor),
          4: FixedColumnWidth(32.0 * multiFactor),
          5: FixedColumnWidth(32.0 * multiFactor),
          6: FixedColumnWidth(32.0 * multiFactor),
          7: FixedColumnWidth(32.0 * multiFactor),
          8: FixedColumnWidth(42.0 * multiFactor),
          9: FixedColumnWidth(62.0 * multiFactor),
        };
      } else {
        double multiFactor = screenWidth / 565;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(84.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(42.0 * multiFactor),
          4: FixedColumnWidth(32.0 * multiFactor),
          5: FixedColumnWidth(32.0 * multiFactor),
          6: FixedColumnWidth(32.0 * multiFactor),
          7: FixedColumnWidth(32.0 * multiFactor),
          8: FixedColumnWidth(42.0 * multiFactor),
          9: FixedColumnWidth(62.0 * multiFactor),
        };
      }
    }

    return Table(
      columnWidths: getColumnWidth(),
      border: TableBorder.all(color: Colors.white),
      children: [
        TableRow(
          children: [
            const CustomTableCell(text: 'Sr.'),
            CustomTableCell(text: 'Act Size ($dimension)'),
            CustomTableCell(text: 'Chr Size ($dimension)'),
            const CustomTableCell(text: 'Thick'),
            const CustomTableCell(text: 'Rate'),
            const CustomTableCell(text: 'Qty'),
            const CustomTableCell(text: 'HOL'),
            const CustomTableCell(text: 'CNT'),
            const CustomTableCell(text: 'Area'),
            const CustomTableCell(text: 'Amount'),
          ],
        ),
      ],
    );
  }
}
