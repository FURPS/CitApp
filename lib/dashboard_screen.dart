import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const AgendaTab(),
    const OdontogramTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Odontólogo'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.help), onPressed: () {}),
        ],
      ),
      drawer: _buildDrawer(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Odontograma'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF0d6efd)),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/user-avatar.jpg'),
                ),
                const SizedBox(height: 10),
                const Text('Dra. Ana Gómez', style: TextStyle(color: Colors.white)),
                const Text('Odontóloga General', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', 0),
          _buildDrawerItem(Icons.calendar_today, 'Agenda', 1),
          _buildDrawerItem(Icons.medical_services, 'Odontograma', 2),
          _buildDrawerItem(Icons.people, 'Pacientes', 3),
          _buildDrawerItem(Icons.bar_chart, 'Reportes', 4),
          _buildDrawerItem(Icons.settings, 'Configuración', 5),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Cerrar Sesión', 6),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context);
      },
    );
  }
}

// Widgets para las pestañas
class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bienvenida, Dra. Gómez', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          // Estadísticas
          Row(
            children: [
              _buildStatCard('12', 'Citas hoy', Colors.blue),
              const SizedBox(width: 10),
              _buildStatCard('5', 'Nuevos', Colors.green),
              const SizedBox(width: 10),
              _buildStatCard('3', 'Urgentes', Colors.orange),
            ],
          ),
          
          const SizedBox(height: 20),
          const Text('Próximas Citas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          
          // Lista de citas
          _buildAppointmentCard('Juan Pérez', '10:00 AM', 'Limpieza dental', 'Confirmada'),
          _buildAppointmentCard('María González', '11:30 AM', 'Control ortodoncia', 'Pendiente'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              Text(label, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(String patient, String time, String service, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(service),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
            Chip(
              label: Text(status, style: const TextStyle(fontSize: 12, color: Colors.white)),
              backgroundColor: status == 'Confirmada' ? Colors.green : Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaTab extends StatelessWidget {
  const AgendaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Agenda'));
  }
}

class OdontogramTab extends StatelessWidget {
  const OdontogramTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Odontograma'));
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Perfil'));
  }
}
