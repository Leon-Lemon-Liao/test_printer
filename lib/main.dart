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

void main() {
  runApp( MyApp());
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
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  late Uint8List theImageComefromScreenShot;
  ScreenshotController screenshotController = ScreenshotController();
  TextEditingController Printer = TextEditingController();

  double _fontSize16 = 12.0;
  double _fontSize12 = 8.0;
  String _equals = "======================";
  String _line = '-------------------------------------------';

  void testPrint(String printerIp, Uint8List theimageThatComesfr) async {
    print("im inside the test print 2");
     PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      // DEMO RECEIPT
      await testBIZ(printer, theimageThatComesfr);
      print(res.msg);
      await Future.delayed( Duration(seconds: 3), () {
        print("prinnter desconect");
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
        title:  Text("معاينة الوصل قبل الطباعة "),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: Printer,
                decoration:  InputDecoration(hintText: "printer ip"),
              ),
               SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child:  Text(
                  'print res',
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () {
                  screenshotController.capture(delay:  Duration(milliseconds: 10)).then((capturedImage) async {
                    theImageComefromScreenShot = capturedImage!;
                    // theimageThatComesfromThePrinter = capturedImage;
                    testPrint(Printer.text, theImageComefromScreenShot);
                    setState(() {});
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
               SizedBox(
                height: 10,
              ),
              Screenshot(
                controller: screenshotController,
                child: Container(
                    width: 180,
                    child: Column(
                      children: [
                        Row(
                          children:  [
                            Text(
                              "臺灣承穎科技有限公司",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         SizedBox(
                          height: 20,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "店號: 001",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "銷售: 240XXX",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "顧客: Leon",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "客數: 4",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "點數: 200pt",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "桌位: A8",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "儲值: 0",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "統編: 28574267",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text(_equals),
                        Row(
                          children:  [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "品名",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "數量",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "單價",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "金額",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text(_line),
                        Row(
                          children:  [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "叉燒飯",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "三寶飯",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "炸雞腿飯炸雞腿飯炸雞腿飯炸雞腿飯炸雞腿飯",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "200",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text(_line),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "折扣: 20",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "小計: 580",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "減項: 0",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "服務: 0",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text(_line),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "現金: \$1000",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "收現: \$1000",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "找零: \$420",
                                style: TextStyle(fontSize: _fontSize12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text(_equals),
                        Row(
                          children:  [
                            Expanded(
                              child: Text(
                                "客服: 管理者",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "合計: \$580",
                                style: TextStyle(fontSize: _fontSize16),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                         Text("總量:(3) 2024/06/05 13:19:02"),
                         Text("烏龜煢煢孑立 沆瀣一氣踽踽獨行 醍醐灌頂綿綿瓜瓞 奉為圭臬龍行龘龘 犄角旮旯娉婷嫋娜 涕泗滂沱呶呶不休 不稂不莠卬咄嗟 蹀躞 耄耋 饕餮囹圄 蘡薁 覬覦 齟齬狖軛鼯軒 怙惡不悛其靁虺虺 醃臢孑孓陟罰臧否 針砭時弊 鱗次櫛比 一張一翕"),
                      ],
                    )),
              ),
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

  Future<void> testBIZ(NetworkPrinter printer, Uint8List bytes) async {
    final img.Image? image = img.decodeImage(bytes);
    printer.image(image!, align: PosAlign.center);
    printer.feed(3);
  }

  Future<void> printChinese(NetworkPrinter printer) async {
    // 原始中文文本
    // String text = '一二三冬天';
    //  PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // printer.text('123456789');
    // List<int> encodedText = await CharsetConverter.encode('big5', text);
    // printer.rawBytes(encodedText);
    // encodedText = await CharsetConverter.encode('gbk', text);
    // printer.rawBytes(encodedText);
    // printer.textEncoded(Uint8List.fromList(encodedText));//亂碼
    // printer.rawBytes(Uint8List.fromList(encodedText));//亂碼

    String text = '谁谁谁谁谁谁谁谁谁谁谁谁';
    // List<int> encodedText = await CharsetConverter.encode('CP950', text);
    // printer.rawBytes(encodedText);//亂碼
    printer.text(text, styles: PosStyles(codeTable: 'CP950')); //error

    // encodedText = await CharsetConverter.encode('big5', text);
    // printer.rawBytes(encodedText);//亂碼
    // encodedText = await CharsetConverter.encode('gbk', text);
    // printer.rawBytes(encodedText);//亂碼
    // logger.i(Uint8List.fromList(encodedText));

    // printer.textEncoded(Uint8List.fromList(encodedText));
    // printer.rawBytes(Uint8List.fromList(encodedText));

    // printer.text(text,
    //     styles: PosStyles(codeTable: 'CP1252'));
    // printer.text(text,
    //     styles: PosStyles(codeTable: 'CP1252'));
    // printer.text(text,
    //     styles: PosStyles(codeTable: 'CP1252'));

    // printer.text(text);
    // printer.text(text);
    // printer.text(text);

    // String _codeTable = 'CP850';
    // printer.text(text,
    //     styles: PosStyles(codeTable: _codeTable));
    // printer.text(text,
    //     styles: PosStyles(codeTable: _codeTable));
    // printer.text(text,
    //     styles: PosStyles(codeTable: _codeTable));

    // printer.row([
    //   PosColumn(width:8, text: '豚肉・木耳と玉子炒め弁当', styles: PosStyles(align: PosAlign.left), containsChinese: true),
    //   PosColumn(width:4, text: '￥1,990', styles: PosStyles(align: PosAlign.right), containsChinese: true),
    // ]);
    printer.feed(2);
  }

  Future<void> testReceipt(NetworkPrinter printer) async {
    printer.text('=============================================');
    // printer.text(
    //     'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: 'CP1252'));
    // printer.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: 'CP1252'));

    // printer.text('Bold text', styles: PosStyles(bold: true));
    // printer.text('Reverse text', styles: PosStyles(reverse: true));
    // printer.text('Underlined text',
    //     styles: PosStyles(underline: true), linesAfter: 1);
    printer.text('Align left', styles: PosStyles(align: PosAlign.left));
    printer.text('Align center', styles: PosStyles(align: PosAlign.center));
    printer.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    final bytes = generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
    printer.rawBytes(bytes);
    printer.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    printer.feed(2);
    // printer.cut();
  }
}
