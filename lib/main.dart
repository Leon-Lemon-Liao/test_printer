import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:multicast_dns/multicast_dns.dart';
import 'package:network_tools/network_tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_printer/log_tool.dart';
import 'package:test_printer/kitchen01.dart';
import 'package:test_printer/kitchen02.dart';
import 'package:test_printer/receipt03.dart';
import 'package:test_printer/receipt04.dart';
import 'package:test_printer/receipt05.dart';
import 'package:test_printer/receipt01.dart';
import 'package:test_printer/receipt02.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // It's necessary to pass correct path to be able to use this library.
  final appDocDirectory = await getApplicationDocumentsDirectory();
  await configureNetworkTools(appDocDirectory.path, enableDebugging: true);
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
  FToast fToast = FToast();
  late Uint8List _theImageComefromScreenShot;
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController _printerIP = TextEditingController(text: '192.168.0.31');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
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
                onPressed: () async {
                  _screenshotController.capture().then((capturedImage) async {
                    _theImageComefromScreenShot = capturedImage!;
                    setState(() {
                      testPrint('192.168.0.31', _theImageComefromScreenShot);
                      testPrint('192.168.0.108', _theImageComefromScreenShot);
                    });
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
    //紙張寬度
    PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);
    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      showToast('success');
      logger.i('printer.connect success');
      final img.Image? image = img.decodeImage(bytes);
      printer.image(
          img.copyResize(
            image!,
            width: paper.width,
          ),
          align: PosAlign.center);

      printer.feed(2);
      // printer.cut();
      printer.reset();
      printer.disconnect();

    } else if (res == PosPrintResult.timeout) {
      showToast('timeout');
      logger.i('printer.connect timeout');
    } else if (res == PosPrintResult.printerNotSelected) {
      showToast('printerNotSelected');
      logger.i('printer.connect printerNotSelected');
    } else if (res == PosPrintResult.ticketEmpty) {
      showToast('ticketEmpty');
      logger.i('printer.connect ticketEmpty');
    } else if (res == PosPrintResult.printInProgress) {
      showToast('printInProgress');
      logger.i('printer.connect printInProgress');
    } else if (res == PosPrintResult.scanInProgress) {
      showToast('scanInProgress');
      logger.i('printer.connect scanInProgress');
    } else {
      logger.i('printer.connect else');
    }
  }

  void showToast(String message) {
    return fToast.showToast(
      child: Text('printer.connect $message'),
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }
}
