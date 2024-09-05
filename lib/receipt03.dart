import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';

class Receipt03 extends StatelessWidget {
  const Receipt03({
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
          width: 160,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "承穎科技有限公司",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "顧客: 001",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "銷售: 2406050003",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "點數: 0",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "客數: 4",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "儲值: 0",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "桌位: -",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "品名",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "數量",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "單價",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "金額",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Text(
                _line,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: _fontSize8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "叉燒飯",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "三寶飯",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "炸雞腿飯炸雞腿飯炸雞腿飯炸雞腿飯炸雞腿飯",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "200",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Text(
                _line,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: _fontSize8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "折扣: 20",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "小計: 580",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "減項: 0",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "服務: 0",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Text(
                _line,
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: _fontSize8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "現金: \$1000",
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
                      "收現: \$1000",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "找零: \$420",
                      style: TextStyle(fontSize: _fontSize8),
                      textAlign: TextAlign.left,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "客服: 管理者",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "合計: \$580",
                      style: TextStyle(fontSize: _fontSize10),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "總量:(3) 2024/06/05 13:19:02",
                    style: TextStyle(fontSize: _fontSize8),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "本次點數: 0",
                    style: TextStyle(fontSize: _fontSize8),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "簽名: ＿＿＿＿＿＿＿＿＿",
                    style: TextStyle(fontSize: _fontSize10),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}