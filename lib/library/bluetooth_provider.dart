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
  BluetoothConnection? connection;

  final List<BluetoothDevice> _devicesList = [];
  List<BluetoothDevice> get devicesList => _devicesList;

  BluetoothProvider() {
    _init();
  }

  Future<void> _init() async {
    // Request permissions
    await Permission.bluetooth.request();
    await Permission.location.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();

    // Auto turn on Bluetooth if needed
    if (!await flutterBlue.isEnabled) {
      flutterBlue.turnOn();
    }

    startScan();

    // Scan results listener
    flutterBlue.scanResults.listen((device) {
      // Avoid duplicates + only valid names
      if (!_devicesList.any((d) => d.address == device.address)) {
        if ((device.name ?? "").isNotEmpty) {
          _devicesList.add(device);
          notifyListeners();
        }
      }
    });

    // Bluetooth ON/OFF listener
    flutterBlue.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        startScan();
      } else {
        stopScan();
      }
      notifyListeners();
    });
  }

  // Start scan if not scanning
  void startScan() {
    if (!isScanning) {
      isScanning = true;
      flutterBlue.startScan();
      notifyListeners();
    }
  }

  // Stop scan if scanning
  void stopScan() {
    if (isScanning) {
      isScanning = false;
      flutterBlue.stopScan();
      notifyListeners();
    }
  }

  // Connect to a device
  Future<void> connectToDevice(BluetoothDevice device) async {
    // Only connect if not already connected
    if (!await checkConnection()) {
      connection = await flutterBlue.connect(device.address);

      if (connection != null) {
        connectedDevice = device;
        stopScan(); // stop scanning after successful connection
        print("Connected to: ${connectedDevice?.name}");
      } else {
        connectedDevice = null;
      }
    }
    notifyListeners();
  }

  // Send brightness value
  Future<void> setBrightness(int brightness) async {
    if (connectedDevice != null && await checkConnection()) {
      connection?.output.add(utf8.encode("B$brightness"));
      await connection?.output.allSent;
    }
  }

  // Send general data
  Future<void> sendData(String data) async {
    if (connectedDevice != null && await checkConnection()) {
      connection?.output.add(utf8.encode(data));
      await connection?.output.allSent;
    }
    notifyListeners();
  }

  // Check connection state
  Future<bool> checkConnection() async {
    try {
      final isConnected = connection?.isConnected ?? false;

      if (isConnected) return true;

      // If disconnected
      connectedDevice = null;
      connection = null;
      notifyListeners();
      return false;
    } catch (e) {
      connectedDevice = null;
      connection = null;
      notifyListeners();
      return false;
    }
  }

  // Disconnect safely
  Future<void> disconnect() async {
    if (await checkConnection()) {
      await connection?.close();
    }
    connectedDevice = null;
    connection = null;
    notifyListeners();
  }
}
