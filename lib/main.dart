import 'dart:convert';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:screenshot/screenshot.dart';
import 'package:test_printer/log_tool.dart';
import 'package:test_printer/kitchen01.dart';
import 'package:test_printer/kitchen02.dart';
import 'package:test_printer/receipt03.dart';
import 'package:test_printer/receipt04.dart';
import 'package:test_printer/receipt05.dart';
import 'package:test_printer/receipt01.dart';
import 'package:test_printer/receipt02.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Uint8List _theImageComefromScreenShot;
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController _printerIP = TextEditingController(text: '192.168.0.33');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer Test"),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _printerIP,
                decoration: InputDecoration(hintText: "printer ip"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(
                  'print res',
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () {
                  _screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
                    _theImageComefromScreenShot = capturedImage!;
                    testPrint(_printerIP.text, _theImageComefromScreenShot);
                    setState(() {});
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
              SizedBox(height: 10),
              Kitchen01(screenshotController: _screenshotController),
              // Kitchen02(screenshotController: _screenshotController),
              // Receipt01(screenshotController: _screenshotController),
              // Receipt02(screenshotController: _screenshotController),
              // Receipt03(screenshotController: _screenshotController),
              // Receipt04(screenshotController: _screenshotController),
              // Receipt05(screenshotController: _screenshotController),
              SizedBox(height: 25),
            ],
          ),
        ],
      )),
    );
  }

  void testPrint(String printerIp, Uint8List bytes) async {
    PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);
    final PosPrintResult res = await printer.connect(printerIp, port: 9100);
    print(paper.width.toString());

    if (res == PosPrintResult.success) {
      final img.Image? image = img.decodeImage(bytes);
      printer.image(img.copyResize(
        image!,
        width: paper.width,
      ), align: PosAlign.center);
      // printer.image(image!, align: PosAlign.center);
      printer.feed(2);
      printer.cut();
      await Future.delayed(Duration(seconds: 3), () {
        printer.disconnect();
      });
    }
  }
}
