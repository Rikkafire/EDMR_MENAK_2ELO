import 'package:project_kanso/library/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:provider/provider.dart';

class ConnectDevices extends StatelessWidget {
  const ConnectDevices({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetooth = Provider.of<BluetoothProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to Devices"),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),

      // We check Bluetooth status only once!
      body: FutureBuilder<bool>(
        future: bluetooth.isEnabled,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error checking Bluetooth status."),
            );
          }

          if (snapshot.data == true) {
            return const DevicesList();
          }

          return const BluetoothOffScreen();
        },
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bluetooth_disabled, size: 100, color: Colors.red),
          SizedBox(height: 16),
          Text(
            "Bluetooth is disabled!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DevicesList extends StatelessWidget {
  const DevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    final bluetooth = Provider.of<BluetoothProvider>(context);
    final devices = bluetooth.devicesList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ListView.separated(
          itemCount: devices.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            BluetoothDevice device = devices[index];

            return ListTile(
              leading: const Icon(
                Icons.devices,
                color: Colors.deepPurple,
                size: 32,
              ),
              title: Text(device.name ?? "Unknown Device"),
              subtitle: Text(device.address.toString()),

              trailing: ElevatedButton.icon(
                icon: const Icon(Icons.link),
                label: const Text("Connect"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: () {
                  bluetooth.connectToDevice(device);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
