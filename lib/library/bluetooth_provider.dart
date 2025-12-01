import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:flutter_blue_classic/flutter_blue_classic.dart";
import "package:permission_handler/permission_handler.dart";

class BluetoothProvider extends ChangeNotifier {
  FlutterBlueClassic flutterBlue = FlutterBlueClassic(usesFineLocation: true);
  Future<bool> get isEnabled => flutterBlue.isEnabled;
  bool isScanning = false;
  BluetoothDevice? connectedDevice;
  final List<BluetoothDevice> _devicesList = [];
  List<BluetoothDevice> get devicesList => _devicesList;
  BluetoothConnection? connection;

  BluetoothProvider() {
    _init();
  }

  Future<void> _init() async {
    await Permission.bluetooth.request();
    await Permission.location.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();

    if (!await flutterBlue.isEnabled) {
      flutterBlue.turnOn();
    }
    startScan();
    notifyListeners();
    flutterBlue.scanResults.listen((results) {
      if (!_devicesList.any((device) => device.address == results.address)) {
        if (results.name != null) {
          print("connect");
          _devicesList.add(results);
          notifyListeners();
        }
      }
    });

    flutterBlue.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        startScan();
      } else if (state == BluetoothAdapterState.off) {
        stopScan();
      }
      notifyListeners();
    });
  }

  void startScan() {
    if (!isScanning) {
      isScanning = true;
      flutterBlue.startScan();
      notifyListeners();
    }
  }

  void stopScan() {
    if (isScanning) {
      isScanning = false;
      flutterBlue.stopScan();
      notifyListeners();
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    if (await checkConnection()) {
      connection = await flutterBlue.connect(device.address);
      if (connection != null) {
        connectedDevice = device;
        print(connectedDevice?.name);
      } else {
        connectedDevice = null;
      }
    }
    notifyListeners();
  }

  Future<void> setBrightness(int brightness) async {
    if (connectedDevice != null && await checkConnection()) {
      connection?.output.add(utf8.encode("B$brightness"));
    }
    notifyListeners();
  }

  Future<void> sendData(String data) async {
    if (connectedDevice != null && await checkConnection()) {
      connection?.output.add(utf8.encode(data));
    }
    notifyListeners();
  }

  Future<bool> checkConnection() async {
    if (connectedDevice != null) {
      try {
        final isConnected = connection?.isConnected ?? false;
        if (isConnected) {
          return true;
        } else {
          connectedDevice = null;
          connection = null;
          notifyListeners();
          return false;
        }
      } catch (e) {
        connectedDevice = null;
        connection = null;
        notifyListeners();
        return false;
      }
    }
    return false;
  }

  Future<void> disconnect() async {
    if (connectedDevice != null && await checkConnection()) {
      await connection?.close();
    }
    connectedDevice = null;
    connection = null;
    notifyListeners();
  }
}
