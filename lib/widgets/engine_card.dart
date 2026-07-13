import 'package:flutter/material.dart';
import '../models/engine.dart';
import '../screens/engine_detail_screen.dart';

class EngineCard extends StatelessWidget {
  final Engine engine;

  const EngineCard({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EngineDetailScreen(engine: engine),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: engine.id,
              child: Image.network(
                engine.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(engine.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('${engine.manufacturer} • ${engine.hp} HP'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${engine.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleMedium),
                      Text(engine.condition),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
