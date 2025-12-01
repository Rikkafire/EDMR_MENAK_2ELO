import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_kanso/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    super.dispose();
  }

  // Add treatment safely
  Future<void> addTreatment(String name, String duration) async {
    try {
      await firestore.collection('treatments').add({
        'name': name,
        'duration': duration,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding treatment: $e')));
    }
  }

  // Delete treatment safely
  Future<void> deleteTreatment(String docId) async {
    try {
      await firestore.collection('treatments').doc(docId).delete();
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting treatment: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('treatments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(child: Text("No treatments yet."));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 149, 255),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              128,
                              70,
                              70,
                              // ignore: deprecated_member_use
                            ).withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'name: ${data['name'] ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Duration: ${data['duration'] ?? ''} hours',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.note,
                                  color: Colors.orange,
                                ),
                                onPressed: () {
                                  // Pre-fill existing note if exists
                                  final TextEditingController notesController =
                                      TextEditingController(
                                        text: data['notes'] ?? '',
                                      );

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Notes"),
                                      content: TextField(
                                        controller: notesController,
                                        maxLines: 5,
                                        decoration: const InputDecoration(
                                          hintText: "Write your notes here...",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // Save notes in Firestore
                                            await firestore
                                                .collection('treatments')
                                                .doc(doc.id)
                                                .update({
                                                  'notes': notesController.text,
                                                  'updatedAt':
                                                      FieldValue.serverTimestamp(),
                                                });
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  // Show edit dialog
                                  nameController.text = data['name'] ?? '';
                                  durationController.text =
                                      data['duration'] ?? '';

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Edit Treatment"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              labelText: "Name",
                                            ),
                                          ),
                                          TextField(
                                            controller: durationController,
                                            decoration: const InputDecoration(
                                              labelText: "Duration",
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (nameController
                                                    .text
                                                    .isNotEmpty &&
                                                durationController
                                                    .text
                                                    .isNotEmpty) {
                                              // Update Firestore
                                              await firestore
                                                  .collection('treatments')
                                                  .doc(doc.id)
                                                  .update({
                                                    'name': nameController.text,
                                                    'duration':
                                                        durationController.text,
                                                    'updatedAt':
                                                        FieldValue.serverTimestamp(),
                                                  });
                                              nameController.clear();
                                              durationController.clear();
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text("Update"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // Delete confirmation
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Delete Treatment"),
                                      content: const Text(
                                        "Are you sure you want to delete this treatment?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            deleteTreatment(doc.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    // Show Add Treatment dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("New Treatment"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                labelText: "Name",
                              ),
                            ),
                            TextField(
                              controller: durationController,
                              decoration: const InputDecoration(
                                labelText: "Duration",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (nameController.text.isNotEmpty &&
                                  durationController.text.isNotEmpty) {
                                addTreatment(
                                  nameController.text,
                                  durationController.text,
                                );
                                nameController.clear();
                                durationController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
