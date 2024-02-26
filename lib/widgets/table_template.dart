import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/custom_table_cell.dart';

class TableTemplate extends StatelessWidget {
  final String dimension;
  const TableTemplate({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(35.0),
        1: FixedColumnWidth(100.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(40.0),
        4: FixedColumnWidth(40.0),
        5: FixedColumnWidth(40.0),
        6: FixedColumnWidth(50.0),
        7: FixedColumnWidth(70.0),
      },
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
            const CustomTableCell(text: 'Area'),
            const CustomTableCell(text: 'Amount'),
          ],
        ),
      ],
    );
  }
}
