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
import 'package:test_printer/receipt01.dart';
import 'package:test_printer/receipt03.dart';
import 'package:test_printer/receipt04.dart';
import 'package:test_printer/receipt05.dart';
import 'package:test_printer/receipt07.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Uint8List _theImageComefromScreenShot;
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController _printerIP = TextEditingController(text: '192.168.0.33');

  double _fontSize10 = 10.0;
  double _fontSize8 = 8.0;
  String _equals = "================================================================================";
  String _line = '----------------------------------------------------------------------------';

  void testPrint(String printerIp, Uint8List bytes) async {
    PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);
    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      final img.Image? image = img.decodeImage(bytes);
      printer.image(image!, align: PosAlign.center);
      printer.feed(2);
      await Future.delayed(Duration(seconds: 3), () {
        logger.i("printer disconnect");
        printer.disconnect();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text(
                  'print res',
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () {
                  _screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
                    _theImageComefromScreenShot = capturedImage!;
                    // testPrint(_printerIP.text, _theImageComefromScreenShot);
                    setState(() {});
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              // Receipt01(screenshotController: _screenshotController),
              // Receipt02(screenshotController: _screenshotController),
              // Receipt03(screenshotController: _screenshotController),
              // Receipt04(screenshotController: _screenshotController),
              Receipt05(screenshotController: _screenshotController),
              // Receipt07(screenshotController: _screenshotController),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      )),
    );
    ;
  }

  // Future<void> testBIZ(NetworkPrinter printer, Uint8List bytes) async {
  //   final img.Image? image = img.decodeImage(bytes);
  //   printer.image(image!, align: PosAlign.center);
  //   printer.feed(3);
  // }
}
