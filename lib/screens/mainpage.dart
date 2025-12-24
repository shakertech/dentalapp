import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/responsive_provider.dart';
import '../providers/theme_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ResponsiveProvider>(
      context,
      listen: false,
    ).update(MediaQuery.of(context).size);
    final responsive = Provider.of<ResponsiveProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    // Mobile/Tablet layout uses Drawer, Desktop uses Row with Sidebar
    if (responsive.isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            _buildSidebar(context),
            Expanded(child: _buildBody(context, user)),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Dental Dashboard')),
        drawer: Drawer(child: _buildSidebarContent(context)),
        body: _buildBody(context, user),
      );
    }
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).cardColor,
      child: _buildSidebarContent(context),
    );
  }

  Widget _buildSidebarContent(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        DrawerHeader(
          child: Center(
            child: Icon(
              Icons.medical_services,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Dashboard'),
          onTap: () {},
          selected: true,
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Patients'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Appointments'),
          onTap: () {},
        ),
        const Spacer(),
        ListTile(
          leading: Icon(
            themeProvider.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          title: const Text('Toggle Theme'),
          onTap: () => themeProvider.toggleTheme(),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
            // AuthWrapper will handle redirection
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBody(BuildContext context, Map<String, dynamic>? user) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${user?['name'] ?? 'User'}!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: Provider.of<ResponsiveProvider>(context).isDesktop
                  ? 3
                  : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildStatCard(
                  context,
                  'Total Patients',
                  '125',
                  Icons.people,
                  Colors.blue,
                ),
                _buildStatCard(
                  context,
                  'Appointments Today',
                  '8',
                  Icons.calendar_today,
                  Colors.orange,
                ),
                _buildStatCard(
                  context,
                  'Pending Bills',
                  '\$4,500',
                  Icons.attach_money,
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
