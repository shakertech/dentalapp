import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/responsive_provider.dart';
import '../providers/theme_provider.dart';
import '../menubar/sidebar.dart';
import '../menubar/bottombar.dart';
import 'appointments.dart';
import 'patients/patients.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ResponsiveProvider>(
        context,
        listen: false,
      ).update(MediaQuery.of(context).size);
    });

    final responsive = Provider.of<ResponsiveProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    Widget content;
    switch (_selectedIndex) {
      case 0:
        content = _buildDashboard(context, user, responsive.isDesktop);
        break;
      case 1:
        content = const AppointmentsScreen();
        break;
      case 2:
        content = const PatientsScreen();
        break;
      case 3:
        content = const Center(child: Text('More Page'));
        break;
      default:
        content = _buildDashboard(context, user, responsive.isDesktop);
    }

    if (responsive.isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            SideBar(
              selectedIndex: _selectedIndex,
              onItemSelected: _onItemSelected,
            ),
            Expanded(child: content),
          ],
        ),
      );
    } else {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return Scaffold(
        // Remvoed AppBar to allow custom header in dashboard
        body: SafeArea(child: content),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemSelected,
        ),
      );
    }
  }

  Widget _buildDashboard(
    BuildContext context,
    Map<String, dynamic>? user,
    bool isDesktop,
  ) {
    // Grid items data based on DIMS image
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Search', 'icon': Icons.search, 'color': Colors.cyan},
      {
        'title': 'Drug By Generic',
        'icon': Icons.medication,
        'color': Colors.blue,
      },
      {'title': 'Drug By Class', 'icon': Icons.share, 'color': Colors.indigo},
      {'title': 'Drug By Indication', 'icon': Icons.hub, 'color': Colors.teal},
      {
        'title': 'Prescription',
        'icon': Icons.description,
        'color': Colors.blueAccent,
      },
      {
        'title': 'Practice Update',
        'icon': Icons.mobile_friendly,
        'color': Colors.green,
      },
      {'title': 'Guidelines', 'icon': Icons.menu_book, 'color': Colors.teal},
      {
        'title': 'Investigation Locator',
        'icon': Icons.location_on,
        'color': Colors.indigoAccent,
      },
      {'title': 'Diseases', 'icon': Icons.sick, 'color': Colors.cyan},
    ];

    return Column(
      children: [
        // Custom Header/Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: Provider.of<ThemeProvider>(context).primaryGradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DENTAL M.S.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).logout();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Database update on: 24 Dec 25',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              // Placeholder for the hex/diagram image
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.hub, size: 60, color: Colors.white24),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 6 : 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'], size: 32, color: item['color']),
                      const SizedBox(height: 12),
                      Text(
                        item['title'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
