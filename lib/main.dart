import 'package:flutter/material.dart';
void main() => runApp(const TodoApp());
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'To-Do List',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)), useMaterial3: true),
        home: const TodoHome(),
      );
}
class TodoHome extends StatefulWidget {
  const TodoHome({super.key});
  @override
  State<TodoHome> createState() => _TodoHomeState();
}
class _TodoHomeState extends State<TodoHome> {
  final _items = <(String, bool)>[];
  final _c = TextEditingController();
  void _add() {
    if (_c.text.trim().isEmpty) return;
    setState(() { _items.add((_c.text.trim(), false)); _c.clear(); });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Tasks')),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(child: TextField(controller: _c, decoration: const InputDecoration(labelText: 'What needs doing?', border: OutlineInputBorder()), onSubmitted: (_) => _add())),
              const SizedBox(width: 8),
              FilledButton(onPressed: _add, child: const Text('Add')),
            ]),
          ),
          Expanded(child: _items.isEmpty
              ? const Center(child: Text('No tasks yet. Add your first one above!'))
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (_, i) => CheckboxListTile(
                    value: _items[i].$2,
                    title: Text(_items[i].$1, style: TextStyle(decoration: _items[i].$2 ? TextDecoration.lineThrough : null)),
                    onChanged: (v) => setState(() => _items[i] = (_items[i].$1, v ?? false)),
                    secondary: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => _items.removeAt(i))),
                  ),
                )),
        ]),
      );
}
