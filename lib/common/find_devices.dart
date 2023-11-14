import 'dart:io';
import 'package:network_info_plus/network_info_plus.dart';

Future<void> scanNetwork() async {
  final wifiIP = await NetworkInfo().getWifiIP();
  final String subnet = wifiIP!.substring(0, wifiIP.lastIndexOf('.'));
  const port = 8888;
  for (var i = 0; i < 256; i++) {
    String ip = '$subnet.$i';
    await Socket.connect(ip, port, timeout: const Duration(milliseconds: 50))
        .then((socket) async {
      await InternetAddress(socket.address.address).reverse().then((value) {
        print(value.host);
        print(socket.address.address);
      }).catchError((error) {
        print(socket.address.address);
        print('Error: $error');
      });
      socket.destroy();
    }).catchError((error) => null);
  }
}
