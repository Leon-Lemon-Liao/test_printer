import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';

class Receipt01 extends StatelessWidget {
  const Receipt01({
    super.key,
    required ScreenshotController screenshotController,
  }) : _screenshotController = screenshotController;

  final ScreenshotController _screenshotController;
  final double _fontSize12 = 12.0;
  final double _fontSize10 = 10.0;
  final double _fontSize8 = 8.0;
  final String _equals = "=============================================================================";
  final String _line = '----------------------------------------------------------------------------';

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Container(
          width: 200,
          child: Column(
            children: [
              Text(
                "承穎科技有限公司",
                style: TextStyle(fontSize: _fontSize12),
              ),
              SizedBox(height: 5),
              Text(
                "403台中市西區臺灣大道二段台中市西\n區臺灣大道二段573號10F-D",
                style: TextStyle(fontSize: _fontSize8),
                textAlign: TextAlign.center,
              ),
              Text(
                " 0423105606",
                style: TextStyle(fontSize: _fontSize8),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "TAX INVOICE",
                style: TextStyle(fontSize: _fontSize10),
                textAlign: TextAlign.center,
              ),
              Text(
                _equals,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: _fontSize8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "叉燒飯",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "*1",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "\$200",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "叉燒飯",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "*10001",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "\$20000",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "炸雞腿飯60炸雞腿飯炸飯炸飯炸雞腿飯60",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "*10",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "\$2000",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Text(
                _equals,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: _fontSize8),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "TOTAL: \$20",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "DISCOUNT: \$580",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "CASH: \$1000",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "CHANGE: \$1000",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Date: 2024/06/05",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Time: 13:19:02",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Table:",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Sale No: SA2406050004",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
