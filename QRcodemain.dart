import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';



class QRcodescan extends StatefulWidget {
  const QRcodescan({Key? key}) : super(key: key);

  @override
  State<QRcodescan> createState() => _QRcodescanState();
}

class _QRcodescanState extends State<QRcodescan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR 코드 스캔'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex:5,
            child: Center(
              child: Text("스캔 : $result"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                ElevatedButton(onPressed: () {
                  if(result.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text : result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("클립보드에 복사하기"),
                      ),
                    );
                  }
                },
                  child: Text("복사"),
                ),
                ElevatedButton(onPressed: () async {
                  if(result.isNotEmpty) {
                    final Uri _url = Uri.parse(result);
                    await launchUrl(_url);
                  }
                },
                    child: Text("인터넷에서 열기")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}