import 'package:flutter/material.dart';

void main() {
  runApp(const DieselEngineApp());
}

class DieselEngineApp extends StatelessWidget {
  const DieselEngineApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diesel Engine Listings',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const EngineListScreen(),
    );
  }
}

class EngineListScreen extends StatelessWidget {
  const EngineListScreen({super.key});

  static const List<Map<String, String>> engines = [
    {
      'name': 'Deutz Diesel Engine',
      'hp': '420',
      'condition': 'Refurbished',
      'imageUrl':
          'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Cummins Diesel Engine',
      'hp': '520',
      'condition': 'Like New',
      'imageUrl':
          'https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Perkins Diesel Engine',
      'hp': '380',
      'condition': 'Used',
      'imageUrl':
          'https://images.unsplash.com/photo-1581092580497-e0d23cbdf1dc?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Volvo Penta Diesel',
      'hp': '460',
      'condition': 'Certified',
      'imageUrl':
          'https://images.unsplash.com/photo-1541888946425-d81bb19240f5?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diesel Engines'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: engines.length,
        itemBuilder: (context, index) {
          final engine = engines[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  engine['imageUrl']!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        engine['name']!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text('HP: ${engine['hp']}'),
                      Text('Condition: ${engine['condition']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
