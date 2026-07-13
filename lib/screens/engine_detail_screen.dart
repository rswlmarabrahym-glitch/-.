import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/engine.dart';

class EngineDetailScreen extends StatelessWidget {
  final Engine engine;

  const EngineDetailScreen({super.key, required this.engine});

  void _showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _call(String phone) async {
    final uri = Uri.parse('tel:$phone');
    await launchUrl(uri);
  }

  Future<void> _whatsapp(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri.parse('https://wa.me/$cleaned');
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(engine.name)),
      body: ListView(
        children: [
          Hero(tag: engine.id, child: Image.network(engine.imageUrl, height: 300, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(engine.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('${engine.manufacturer} • ${engine.hp} HP', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('\$${engine.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text(engine.condition, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 12),
                Text(engine.description),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.phone),
                        label: const Text('Call'),
                        onPressed: () async {
                          try {
                            await _call(engine.phone);
                          } catch (_) {
                            _showSnack(context, 'Unable to place call');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        icon: const Icon(Icons.whatsapp),
                        label: const Text('WhatsApp'),
                        onPressed: () async {
                          try {
                            await _whatsapp(engine.phone);
                          } catch (_) {
                            _showSnack(context, 'Unable to open WhatsApp');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
