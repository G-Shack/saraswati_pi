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
  TextEditingController controller3mm = TextEditingController();
  TextEditingController controller3pt5mm = TextEditingController();
  TextEditingController controller4mm = TextEditingController();
  TextEditingController controller5mm = TextEditingController();
  TextEditingController controller6mm = TextEditingController();
  TextEditingController controller8mm = TextEditingController();
  TextEditingController controller10mm = TextEditingController();
  TextEditingController controller12mm = TextEditingController();
  TextEditingController controller15mm = TextEditingController();
  TextEditingController controllerHoles = TextEditingController();
  TextEditingController controllerCnt = TextEditingController();

  @override
  void initState() {
    loadRates();
    super.initState();
  }

  @override
  void dispose() {
    controller2mm.dispose();
    controller3mm.dispose();
    controller3pt5mm.dispose();
    controller4mm.dispose();
    controller5mm.dispose();
    controller6mm.dispose();
    controller8mm.dispose();
    controller10mm.dispose();
    controller12mm.dispose();
    controller15mm.dispose();
    controllerHoles.dispose();
    controllerCnt.dispose();
    super.dispose();
  }

  void loadRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var ratesString = prefs.getString('rates');
      if (ratesString != null) {
        rates = Map<String, Object>.from(jsonDecode(ratesString));
        controller2mm.text = rates['2mm'].toString();
        controller3mm.text = rates['3mm'].toString();
        controller3pt5mm.text = rates['3.5mm'].toString();
        controller4mm.text = rates['4mm'].toString();
        controller5mm.text = rates['5mm'].toString();
        controller6mm.text = rates['6mm'].toString();
        controller8mm.text = rates['8mm'].toString();
        controller10mm.text = rates['10mm'].toString();
        controller12mm.text = rates['12mm'].toString();
        controller15mm.text = rates['15mm'].toString();
        controllerHoles.text = rates['holes'].toString();
        controllerCnt.text = rates['cnt'].toString();
      } else {
        rates = {
          '2mm': 1,
          '3mm': 1,
          '3.5mm': 1,
          '4mm': 1,
          '5mm': 1,
          '6mm': 1,
          '8mm': 1,
          '10mm': 1,
          '12mm': 1,
          '15mm': 1,
          'holes': 1,
          'cnt': 1,
        };
        controller2mm.text = '1';
        controller3mm.text = '1';
        controller3pt5mm.text = '1';
        controller4mm.text = '1';
        controller5mm.text = '1';
        controller6mm.text = '1';
        controller8mm.text = '1';
        controller10mm.text = '1';
        controller12mm.text = '1';
        controller15mm.text = '1';
        controllerHoles.text = '1';
        controllerCnt.text = '1';
      }
    });
  }

  void updateRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final updateRates = {
      '2mm': double.parse(controller2mm.text),
      '3mm': double.parse(controller3mm.text),
      '3.5mm': double.parse(controller3pt5mm.text),
      '4mm': double.parse(controller4mm.text),
      '5mm': double.parse(controller5mm.text),
      '6mm': double.parse(controller6mm.text),
      '8mm': double.parse(controller8mm.text),
      '10mm': double.parse(controller10mm.text),
      '12mm': double.parse(controller12mm.text),
      '15mm': double.parse(controller15mm.text),
      'holes': double.parse(controllerHoles.text),
      'cnt': double.parse(controllerCnt.text),
    };
    if (!mapEquals(rates, updateRates)) {
      setState(() {
        rates = updateRates;
      });
    }
    var savedSnack = const SnackBar(
      content: Text(
        'Saved!',
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1, milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(savedSnack);
    FocusManager.instance.primaryFocus?.unfocus();
    prefs.setString('rates', jsonEncode(rates));
  }

  void clearRates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    loadRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rates'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: clearRates),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 32.0, right: 32.0, top: 12.0, bottom: 12.0),
        child: ListView(
          children: [
            const Text(
              'Set Glass Rates',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            SetRatesTxtField(
              controller1: controller2mm,
              name1: '2mm',
              controller2: controller3mm,
              name2: '3mm',
            ),
            SetRatesTxtField(
                controller1: controller3pt5mm,
                name1: '3.5mm',
                controller2: controller4mm,
                name2: '4mm'),
            SetRatesTxtField(
                controller1: controller5mm,
                name1: '5mm',
                controller2: controller6mm,
                name2: '6mm'),
            SetRatesTxtField(
                controller1: controller8mm,
                name1: '8mm',
                controller2: controller10mm,
                name2: '10mm'),
            SetRatesTxtField(
              controller1: controller12mm,
              name1: '12mm',
              controller2: controller15mm,
              name2: '15mm',
            ),
            SetRatesTxtField(
              controller1: controllerHoles,
              name1: 'Holes Rate',
              controller2: controllerCnt,
              name2: 'Cutout Rate',
            ),
            DimensionButton(btnTxt: 'Save', fun: updateRates),
          ],
        ),
      ),
    );
  }
}
