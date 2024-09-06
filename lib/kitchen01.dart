import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';

class Kitchen01 extends StatelessWidget {
  const Kitchen01({
    super.key,
    required ScreenshotController screenshotController,
  }) : _screenshotController = screenshotController;

  final ScreenshotController _screenshotController;
  final double _fontSize12 = 12.0;
  final double _fontSize10 = 10.0;
  final double _fontSize8 = 8.0;
  final String _equals = "================================================================================";
  final String _line = '----------------------------------------------------------------------------';

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Container(
          width: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "承穎科技有限公司",
                    style: TextStyle(fontSize: _fontSize12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "004",
                    style: TextStyle(fontSize: _fontSize12),
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
                    flex: 4,
                    child: Text(
                      "雞腿飯",
                      style: TextStyle(fontSize: _fontSize12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: _fontSize12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "叉燒飯叉燒飯叉燒飯叉燒飯叉燒飯叉飯",
                      style: TextStyle(fontSize: _fontSize12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: _fontSize12),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '點餐: 管理者',
                    style: TextStyle(fontSize: _fontSize12),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '2024/11/11 11:11:11',
                    style: TextStyle(fontSize: _fontSize8),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
