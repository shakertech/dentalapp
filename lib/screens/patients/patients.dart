import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'addpatient.dart';
import 'viewpatient.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock data for patients
  final List<Map<String, dynamic>> _allPatients = [
    {
      'name': 'Alice Smith',
      'age': 28,
      'gender': 'Female',
      'lastVisit': '2024-12-20',
      'condition': 'Routine Checkup',
      'avatarColor': Colors.purple,
    },
    {
      'name': 'Bob Johnson',
      'age': 45,
      'gender': 'Male',
      'lastVisit': '2024-11-15',
      'condition': 'Root Canal',
      'avatarColor': Colors.blue,
    },
    {
      'name': 'Charlie Brown',
      'age': 12,
      'gender': 'Male',
      'lastVisit': '2024-12-22',
      'condition': 'Braces Adjustment',
      'avatarColor': Colors.green,
    },
    {
      'name': 'Diana Prince',
      'age': 32,
      'gender': 'Female',
      'lastVisit': '2024-10-30',
      'condition': 'Whitening',
      'avatarColor': Colors.orange,
    },
    {
      'name': 'Evan Wright',
      'age': 55,
      'gender': 'Male',
      'lastVisit': '2024-09-12',
      'condition': 'Gum Treatment',
      'avatarColor': Colors.teal,
    },
    {
      'name': 'Fiona Gallagher',
      'age': 24,
      'gender': 'Female',
      'lastVisit': '2024-12-01',
      'condition': 'Cavity Filling',
      'avatarColor': Colors.pink,
    },
  ];

  List<Map<String, dynamic>> get _filteredPatients {
    if (_searchQuery.isEmpty) {
      return _allPatients;
    }
    return _allPatients.where((patient) {
      final name = (patient['name'] as String).toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredList = _filteredPatients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: Provider.of<ThemeProvider>(context).primaryGradient,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPatientScreen()),
          );
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          // Patient List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 64,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No patients found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final patient = filteredList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: patient['avatarColor'] as Color,
                          child: Text(
                            (patient['name'] as String)[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          patient['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${patient['gender']}, ${patient['age']} years • Last visit: ${patient['lastVisit']}',
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewPatientScreen(patient: patient),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
