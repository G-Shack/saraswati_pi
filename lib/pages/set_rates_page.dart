import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/app_drawer.dart';

class SetRatesPage extends StatefulWidget {
  const SetRatesPage({super.key});

  @override
  State<SetRatesPage> createState() => _SetRatesPageState();
}

class _SetRatesPageState extends State<SetRatesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Rates'),
      ),
      drawer: AppDrawer(),
    );
  }
}
