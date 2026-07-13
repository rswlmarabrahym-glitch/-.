import 'package:flutter/material.dart';
import '../data/engines.dart';
import '../models/engine.dart';
import '../widgets/engine_card.dart';
import 'engine_detail_screen.dart';

class EngineListScreen extends StatefulWidget {
  const EngineListScreen({super.key});

  @override
  State<EngineListScreen> createState() => _EngineListScreenState();
}

class _EngineListScreenState extends State<EngineListScreen> {
  List<Engine> engines = List.from(sampleEngines);
  String query = '';
  String? filterManufacturer;

  List<String> get manufacturers => ['All', ...{for (var e in sampleEngines) e.manufacturer}];

  void _addEngine(Engine engine) {
    setState(() => engines.insert(0, engine));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Engine added')));
  }

  void _openAddDialog() {
    final nameCtrl = TextEditingController();
    final manufacturerCtrl = TextEditingController();
    final hpCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final conditionCtrl = TextEditingController();
    final imageCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Engine'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: manufacturerCtrl, decoration: const InputDecoration(labelText: 'Manufacturer')),
              TextField(controller: hpCtrl, decoration: const InputDecoration(labelText: 'HP'), keyboardType: TextInputType.number),
              TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              TextField(controller: conditionCtrl, decoration: const InputDecoration(labelText: 'Condition')),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: imageCtrl, decoration: const InputDecoration(labelText: 'Image URL')),
              TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final engine = Engine(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameCtrl.text.isEmpty ? 'New Engine' : nameCtrl.text,
                manufacturer: manufacturerCtrl.text.isEmpty ? 'Unknown' : manufacturerCtrl.text,
                hp: int.tryParse(hpCtrl.text) ?? 0,
                price: double.tryParse(priceCtrl.text) ?? 0.0,
                condition: conditionCtrl.text.isEmpty ? 'Used' : conditionCtrl.text,
                description: descCtrl.text.isEmpty ? 'No description' : descCtrl.text,
                imageUrl: imageCtrl.text.isEmpty ? sampleEngines.first.imageUrl : imageCtrl.text,
                phone: phoneCtrl.text.isEmpty ? '+000' : phoneCtrl.text,
              );
              _addEngine(engine);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = engines.where((e) {
      final matchQuery = query.isEmpty || e.name.toLowerCase().contains(query.toLowerCase());
      final matchFilter = filterManufacturer == null || filterManufacturer == 'All' || e.manufacturer == filterManufacturer;
      return matchQuery && matchFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diesel Engine Marketplace'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: _EngineSearchDelegate(engines, onSelected: (engine) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => engine == null ? const SizedBox() : EngineDetailScreen(engine: engine)));
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: filterManufacturer ?? 'All',
                    items: manufacturers.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                    onChanged: (v) => setState(() => filterManufacturer = v),
                    decoration: const InputDecoration(labelText: 'Manufacturer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Search'),
                    onChanged: (v) => setState(() => query = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('No engines found'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) => EngineCard(engine: filtered[index]),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EngineSearchDelegate extends SearchDelegate {
  final List<Engine> engines;
  final void Function(Engine?) onSelected;

  _EngineSearchDelegate(this.engines, {required this.onSelected});

  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final results = engines.where((e) => e.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        leading: Image.network(results[index].imageUrl, width: 60, fit: BoxFit.cover),
        title: Text(results[index].name),
        subtitle: Text(results[index].manufacturer),
        onTap: () => onSelected(results[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = engines.where((e) => e.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        leading: Image.network(suggestions[index].imageUrl, width: 60, fit: BoxFit.cover),
        title: Text(suggestions[index].name),
        onTap: () => onSelected(suggestions[index]),
      ),
    );
  }
}
