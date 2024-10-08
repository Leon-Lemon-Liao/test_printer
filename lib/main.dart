import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late Uint8List _theImageComefromScreenShot;
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController _printerIP = TextEditingController(text: '192.168.0.31');
  String _printerRealIP = '';

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
                onPressed: () async {
                  // await _testMDNS(context);
                  // await _testMDNSbyUDP();
                  await _testMulticastDNS();

                  // _screenshotController.capture(delay: Duration(milliseconds: 10)).then((capturedImage) async {
                  //   _theImageComefromScreenShot = capturedImage!;
                  //   testPrint(_printerIP.text, _theImageComefromScreenShot);
                  //   setState(() {});
                  // }).catchError((onError) {
                  //   print(onError);
                  // });
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

  Future<void> _testMDNS(BuildContext context) async {
    logger.v('start');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // final a = await MdnsScannerService.instance.searchMdnsDevices();
    // if(a.isNotEmpty) {
    //   final b = await a[0].mdnsInfo;
    //   if(b?.mdnsPort ==9100){
    //     logger.i('9100');
    //         _printerRealIP = a[0].address;
    //   }
    //   else{
    //     logger.i('not 9100');
    //   }
    // }
    // else{
    //   logger.i('is empty');
    // }

    while (_printerRealIP == '') {
      logger.i('while');
      for (final ActiveHost activeHost in await MdnsScannerService.instance.searchMdnsDevices()) {
        logger.i('for');
        final MdnsInfo? mdnsInfo = await activeHost.mdnsInfo;
        if (mdnsInfo!.mdnsPort == 9100) {
          _printerRealIP = activeHost.address;
          logger.w('''
          Address: ${activeHost.address}
          Port: ${mdnsInfo.mdnsPort}
          ServiceType: ${mdnsInfo.mdnsServiceType}
          MdnsName: ${mdnsInfo.getOnlyTheStartOfMdnsName()}
          ''');
        } else {
          logger.v('''
            Address: ${activeHost.address}
            Port: ${mdnsInfo.mdnsPort}
            ServiceType: ${mdnsInfo.mdnsServiceType}
            MdnsName: ${mdnsInfo.getOnlyTheStartOfMdnsName()}
            ''');
        }
        // Future.delayed(Duration(seconds: 3));
        // if (mdnsInfo!.mdnsPort == 631) {
        //   logger.wtf('''
        //     Address: ${activeHost.address}
        //     Port: ${mdnsInfo.mdnsPort}
        //     ServiceType: ${mdnsInfo.mdnsServiceType}
        //     MdnsName: ${mdnsInfo.getOnlyTheStartOfMdnsName()}
        //     ''');
        // }
      }
    }
    logger.v('end');
    logger.i('_printerRealIP: ' + _printerRealIP);
    Navigator.of(context).pop();
  }

  void testPrint(String printerIp, Uint8List bytes) async {
    PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);
    final PosPrintResult res = await printer.connect(printerIp, port: 9100);
    print(paper.width.toString());

    if (res == PosPrintResult.success) {
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

      // await Future.delayed(Duration(seconds: 7), () {
      //   printer.reset();
      //   printer.disconnect();
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    // _testMDNSbyUDP();  // 在應用啟動時觸發查詢
  }

  _testMDNSbyUDP() async {
    final String multicastAddress = "224.0.0.251";
    final int port = 5353;

    // 建立一個 RawDatagramSocket，用來發送和接收 mDNS 封包
    RawDatagramSocket.bind(InternetAddress.anyIPv4, port).then((RawDatagramSocket socket) {
      // 發送查詢
      String query = "_ipp._tcp.local"; // 這裡假設查詢的是 HTTP 服務
      List<int> queryBytes = utf8.encode(query);

      // 發送 mDNS 查詢封包到多播地址
      socket.send(queryBytes, InternetAddress(multicastAddress), port);
      print("mDNS 查詢發送成功");

      // 監聽查詢結果
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            String response = String.fromCharCodes(datagram.data);
            print("收到的回應: $response");
            // _printerRealIP = ;
          }
        }
      });
    });
  }

  Future<void> _testMulticastDNS() async {
    // Parse the command line arguments.

    // const String name = '_ipp._tcp.local';
    const String name = '_printer._tcp.local';

    final client = MDnsClient(
      // Create a custom RawDatagramSocketFactory to avoid the reusePort issue on Android
      rawDatagramSocketFactory: (dynamic host, int port,
          {bool reuseAddress = true,
            bool reusePort = false,
            int ttl = 255}) {
        return RawDatagramSocket.bind(host, port,
            reuseAddress: reuseAddress,
            reusePort: false,
            ttl: ttl);
      },
    );

    // final MDnsClient client = MDnsClient(
    //   rawDatagramSocketFactory: (dynamic host, int port,
    //       {bool reuseAddress = true, bool reusePort = false, int ttl = 1}) {
    //     return RawDatagramSocket.bind(host, port,
    //         reuseAddress: reuseAddress, reusePort: reusePort, ttl: ttl);
    //   },
    // );

    await client.start();
    // Get the PTR record for the service.
    await for (final PtrResourceRecord ptr in client.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      // logger.i('for1 ptr.domainName: ' + ptr.domainName);
      await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr.domainName))) {
        // logger.i('for2 srv.target: '+ srv.target);
          await for (final IPAddressResourceRecord ip in client.lookup<IPAddressResourceRecord>(ResourceRecordQuery.addressIPv4(srv.target))) {
            // logger.i('for3');
            print('Service found at ${ip.address.address}:${srv.port}');
            print(srv.target);
          }

        // // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
        // final String bundleId =
        //     ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
        // print('Dart observatory instance found at '
        //     '${srv.target}:${srv.port} for "$bundleId".'); //Dart observatory instance found at EPSONEA42C4.local:515 for "EPSON L5290 Series._printer._tcp.local".
        // print(srv.name); //EPSON L5290 Series._printer._tcp.local
        // print(ptr.name); //_printer._tcp.local
        // print(ptr.domainName); //EPSON L5290 Series._printer._tcp.local
      }
    }
    client.stop();

    print('Done.');
  }
}
