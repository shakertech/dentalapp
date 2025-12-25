import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../components/alertDialog.dart';

class AddWorkScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  const AddWorkScreen({super.key, required this.patient});

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();

  // Dynamic list of work items
  final List<Map<String, dynamic>> _workItems = [];
  final _paidController = TextEditingController(text: '0');

  void _addWorkItem() {
    _showAddWorkItemDialog();
  }

  void _showAddWorkItemDialog() {
    final itemController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Work Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cost'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (itemController.text.isNotEmpty &&
                  costController.text.isNotEmpty) {
                setState(() {
                  _workItems.add({
                    'item': itemController.text,
                    'cost': double.tryParse(costController.text) ?? 0,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  double get _totalCost =>
      _workItems.fold(0, (sum, item) => sum + (item['cost'] as num));

  void _save() {
    if (_formKey.currentState!.validate()) {
      // Mock Save
      AnimatedDialog.show(
        context,
        type: DialogType.success,
        title: 'Success',
        message: 'Work recorded successfully.',
        onOkPressed: () {
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Go back to Patient View
        },
      );
    }
  }

  @override
  void dispose() {
    _treatmentController.dispose();
    _notesController.dispose();
    _paidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = _totalCost;
    final paid = double.tryParse(_paidController.text) ?? 0;
    final due = total - paid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Work / Visit'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: Provider.of<ThemeProvider>(context).primaryGradient,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Patient: ${widget.patient['name']}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _treatmentController,
                decoration: const InputDecoration(
                  labelText: 'Treatment Title',
                  prefixIcon: Icon(Icons.medical_services_outlined),
                ),
                validator: (v) => v!.isEmpty ? 'Enter treatment title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Clinical Notes',
                  prefixIcon: Icon(Icons.note_alt_outlined),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Work Items',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _addWorkItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Item'),
                  ),
                ],
              ),
              const Divider(),
              if (_workItems.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No items added yet',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                )
              else
                ..._workItems.map(
                  (item) => ListTile(
                    title: Text(item['item']),
                    trailing: Text('\$${item['cost']}'),
                    dense: true,
                  ),
                ),

              const SizedBox(height: 24),
              Card(
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Cost',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$$total',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _paidController,
                        keyboardType: TextInputType.number,
                        onChanged: (v) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Amount Paid',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Due Amount'),
                          Text(
                            '\$$due',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: due > 0 ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
              FilledButton(
                onPressed: _save,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Record',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
