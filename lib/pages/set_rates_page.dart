import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saraswati_pi/widgets/app_drawer.dart';
import 'package:saraswati_pi/widgets/dimension_button.dart';
import 'package:saraswati_pi/widgets/set_rates_txt_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetRatesPage extends StatefulWidget {
  const SetRatesPage({super.key});

  @override
  State<SetRatesPage> createState() => _SetRatesPageState();
}

class _SetRatesPageState extends State<SetRatesPage> {
  Map<String, Object> rates = {};
  TextEditingController controller2mm = TextEditingController();
  TextEditingController controller4mm = TextEditingController();
  TextEditingController controller5mm = TextEditingController();
  TextEditingController controller6mm = TextEditingController();
  TextEditingController controller8mm = TextEditingController();
  TextEditingController controller10mm = TextEditingController();
  TextEditingController controller12mm = TextEditingController();

  @override
  void initState() {
    loadRates();
    super.initState();
  }

  @override
  void dispose() {
    controller2mm.dispose();
    controller4mm.dispose();
    controller5mm.dispose();
    controller6mm.dispose();
    controller8mm.dispose();
    controller10mm.dispose();
    controller12mm.dispose();
    super.dispose();
  }

  void loadRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var ratesString = prefs.getString('rates');
      if (ratesString != null) {
        rates = Map<String, Object>.from(jsonDecode(ratesString));
        controller2mm.text = rates['2mm'].toString();
        controller4mm.text = rates['4mm'].toString();
        controller5mm.text = rates['5mm'].toString();
        controller6mm.text = rates['6mm'].toString();
        controller8mm.text = rates['8mm'].toString();
        controller10mm.text = rates['10mm'].toString();
        controller12mm.text = rates['12mm'].toString();
      } else {
        rates = {
          '2mm': 1,
          '4mm': 1,
          '5mm': 1,
          '6mm': 1,
          '8mm': 1,
          '10mm': 1,
          '12mm': 1,
        };
        controller2mm.text = '1';
        controller4mm.text = '1';
        controller5mm.text = '1';
        controller6mm.text = '1';
        controller8mm.text = '1';
        controller10mm.text = '1';
        controller12mm.text = '1';
      }
    });
  }

  void updateRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final updateRates = {
      '2mm': double.parse(controller2mm.text),
      '4mm': double.parse(controller4mm.text),
      '5mm': double.parse(controller5mm.text),
      '6mm': double.parse(controller6mm.text),
      '8mm': double.parse(controller8mm.text),
      '10mm': double.parse(controller10mm.text),
      '12mm': double.parse(controller12mm.text),
    };
    if (!mapEquals(rates, updateRates)) {
      setState(() {
        rates = updateRates;
      });
    }
    prefs.setString('rates', jsonEncode(rates));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Text(
                'Set Rates here!',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 10),
              SetRatesTxtField(controller: controller2mm, name: '2mm'),
              SetRatesTxtField(controller: controller4mm, name: '4mm'),
              SetRatesTxtField(controller: controller5mm, name: '5mm'),
              SetRatesTxtField(controller: controller6mm, name: '6mm'),
              SetRatesTxtField(controller: controller8mm, name: '8mm'),
              SetRatesTxtField(controller: controller10mm, name: '10mm'),
              SetRatesTxtField(controller: controller12mm, name: '12mm'),
              DimensionButton(btnTxt: 'Save', fun: updateRates),
            ],
          ),
        ),
      ),
    );
  }
}
