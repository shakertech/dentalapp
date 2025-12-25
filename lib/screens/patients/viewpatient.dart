import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../components/book_appointment_dialog.dart';
import 'add_work.dart';

class ViewPatientScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  const ViewPatientScreen({super.key, required this.patient});

  @override
  State<ViewPatientScreen> createState() => _ViewPatientScreenState();
}

class _ViewPatientScreenState extends State<ViewPatientScreen> {
  // Mock visits data
  final List<Map<String, dynamic>> _visits = [
    {
      'date': '2024-12-20',
      'treatment': 'Root Canal Treatment',
      'notes': 'Upper right molar (16). Patient reported sensitivity.',
      'works': [
        {'item': 'Consultation', 'cost': 500},
        {'item': 'X-Ray', 'cost': 300},
        {'item': 'RCT Phase 1', 'cost': 3000},
      ],
      'payment': {'total': 3800, 'paid': 2000, 'due': 1800},
    },
    {
      'date': '2024-11-15',
      'treatment': 'General Checkup',
      'notes': 'Routine 6-month checkup. Cleaning suggested.',
      'works': [
        {'item': 'Consultation', 'cost': 500},
        {'item': 'Scaling & Polishing', 'cost': 1500},
      ],
      'payment': {'total': 2000, 'paid': 2000, 'due': 0},
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final patient = widget.patient;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task, color: Colors.white),
            tooltip: 'Add Work',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddWorkScreen(patient: widget.patient),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, patient),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPatientDetailsCard(context, patient),
                  const SizedBox(height: 20),
                  _buildNextAppointmentSection(context),
                  const SizedBox(height: 20),
                  Text(
                    'Visits History',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._visits.map((visit) => _buildVisitCard(context, visit)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> patient) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 100, 24, 30),
      decoration: BoxDecoration(
        gradient: Provider.of<ThemeProvider>(context).primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 38,
              backgroundColor: patient['avatarColor'] ?? Colors.blue,
              child: Text(
                (patient['name'] as String)[0],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            patient['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            patient['condition'] ?? 'No active condition',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientDetailsCard(
    BuildContext context,
    Map<String, dynamic> patient,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  context,
                  Icons.calendar_today,
                  'Age',
                  '${patient['age']} yrs',
                ),
                _buildInfoItem(
                  context,
                  Icons.wc,
                  'Gender',
                  patient['gender'] ?? 'N/A',
                ),
                _buildInfoItem(
                  context,
                  Icons.monitor_weight_outlined,
                  'Weight',
                  '${patient['weight'] ?? 70} kg',
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 20),
                const SizedBox(width: 10),
                Text(
                  patient['phone'] ?? '+1 234 567 8900',
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildNextAppointmentSection(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Next Appointment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Monday, 30 Dec 2024 at 10:00 AM',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BookAppointmentDialog(
                          isReschedule: true,
                          patientName: widget.patient['name'],
                          // initialDate: ... (mock logic could parse string)
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                    ),
                    child: const Text('Reschedule'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BookAppointmentDialog(
                          patientName: widget.patient['name'],
                        ),
                      );
                    },
                    child: const Text('Add New'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitCard(BuildContext context, Map<String, dynamic> visit) {
    final theme = Theme.of(context);
    final works = visit['works'] as List<Map<String, dynamic>>;
    final payment = visit['payment'] as Map<String, dynamic>;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.medical_services,
              color: theme.colorScheme.primary,
            ),
          ),
          title: Text(
            visit['date'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            visit['treatment'],
            style: TextStyle(color: Colors.grey[600]),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Notes: ${visit['notes']}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Works:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...works.map(
                    (w) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(w['item']), Text('\$${w['cost']}')],
                      ),
                    ),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${payment['total']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Paid: \$${payment['paid']}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Text(
                        'Due: \$${payment['due']}',
                        style: TextStyle(
                          color: payment['due'] > 0 ? Colors.red : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
