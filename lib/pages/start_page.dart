import 'package:flutter/material.dart';
import 'package:saraswati_pi/pages/dimensions_page_inch.dart';
import 'package:saraswati_pi/pages/dimensions_page_mm.dart';
import 'package:saraswati_pi/widgets/app_drawer.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController billNo = TextEditingController();
  String selectedUnit = "inch";
  Color mmText = Colors.white;
  Color inchText = Colors.black;
  Color inchButton = Colors.amberAccent;
  Color mmButton = Colors.black;

  void setUnit(String unit) {
    if (unit == "inch") {
      selectedUnit = "inch";
      mmText = Colors.white;
      inchText = Colors.black;
      inchButton = Colors.amberAccent;
      mmButton = Colors.black;
    } else {
      selectedUnit = "mm";
      mmText = Colors.black;
      inchText = Colors.white;
      inchButton = Colors.black;
      mmButton = Colors.amberAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glass PI"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: [
                const Material(
                  elevation: 15,
                  shadowColor: Colors.amberAccent,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Select Unit",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setUnit("inch");
                          print(selectedUnit.toString());
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 90,
                        decoration: BoxDecoration(
                          color: inchButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "inch",
                            style: TextStyle(
                                color: inchText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setUnit("mm");
                          print(selectedUnit.toString());
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 90,
                        decoration: BoxDecoration(
                          color: mmButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "mm",
                            style: TextStyle(
                                color: mmText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bill No.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 25),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        keyboardType: TextInputType.datetime,
                        controller: billNo,
                        decoration: const InputDecoration(
                          hintText: "Enter Bill No.",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (selectedUnit == "inch") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DimensionsPageInch()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DimensionsPageMm()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xDDEB1555)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "PROCEED",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
