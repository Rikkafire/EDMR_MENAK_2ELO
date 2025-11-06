import 'package:project_kanso/library/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'package:provider/provider.dart';

class ConnectDevices extends StatelessWidget {
  const ConnectDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to Devices"),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: FutureBuilder<bool>(
        future: Provider.of<BluetoothProvider>(context, listen: true).isEnabled,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error checking Bluetooth status."),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return const DevicesList();
          } else {
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
        },
      ),
    );
  }
}

class DevicesList extends StatelessWidget {
  const DevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = Provider.of<BluetoothProvider>(context).devicesList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ListView.separated(
          itemCount: devices.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (buildContext, index) {
            BluetoothDevice device = devices[index];
            return ListTile(
              leading: const Icon(
                Icons.piano,
                color: Colors.deepPurple,
                size: 32,
              ),
              title: Text(
                device.name ?? "Unknown Device",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(device.address.toString()),
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Provider.of<BluetoothProvider>(
                    context,
                    listen: false,
                  ).connectToDevice(device).then((value) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
                icon: const Icon(Icons.check_rounded),
                label: const Text("Connect"),
              ),
            );
          },
        ),
      ),
    );
  }
}
