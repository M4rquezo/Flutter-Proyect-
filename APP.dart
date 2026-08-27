import 'package:flutter/material.dart';

void main() {
  runApp(const KineticRetentionApp());
}

class KineticRetentionApp extends StatelessWidget {
  const KineticRetentionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kinetic Retention Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066FF)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// -------------------------------------------------------------
// PANTALLA 1: LOGIN
// -------------------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa usuario y contraseña')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined, size: 80, color: Color(0xFF0066FF)),
              const SizedBox(height: 16),
              const Text(
                'Kinetic Retention Assistant',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Usuario / Correo RUI',
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _login,
                  child: const Text('INGRESAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// PANTALLA 2: MENÚ PRINCIPAL (HOME)
// -------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal - Kinetic'),
        backgroundColor: const Color(0xFF0A192F),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuCard(
              context,
              title: 'Módulo ASOCS',
              icon: Icons.qr_code,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AsocsCrudPage()),
                );
              },
            ),
            _buildMenuCard(
              context,
              title: 'Modificar Planes',
              icon: Icons.build,
              color: Colors.orange,
              onTap: () {},
            ),
            _buildMenuCard(
              context,
              title: 'Promociones / Ofertas',
              icon: Icons.local_offer,
              color: Colors.green,
              onTap: () {},
            ),
            _buildMenuCard(
              context,
              title: 'Scripts de Retención',
              icon: Icons.description,
              color: Colors.purple,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// PANTALLA 3: MÓDULO CRUD DE CÓDIGOS ASOCS (DATOS SIMULADOS)
// -------------------------------------------------------------
class AsocsCrudPage extends StatefulWidget {
  const AsocsCrudPage({super.key});

  @override
  State<AsocsCrudPage> createState() => _AsocsCrudPageState();
}

class _AsocsCrudPageState extends State<AsocsCrudPage> {
  final List<Map<String, String>> _asocsList = [
    {'plan': 'Kinetic Fiber 500M', 'code': 'ASOCS-500F', 'discount': '20% Off'},
    {'plan': 'Kinetic Gig Service', 'code': 'ASOCS-1GIG', 'discount': '30% Off'},
  ];

  void _addAsocsCode() {
    final planController = TextEditingController();
    final codeController = TextEditingController();
    final discountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Nuevo Código ASOCS'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: planController, decoration: const InputDecoration(labelText: 'Plan')),
            TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Código DCRIS')),
            TextField(controller: discountController, decoration: const InputDecoration(labelText: 'Descuento')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _asocsList.add({
                  'plan': planController.text,
                  'code': codeController.text,
                  'discount': discountController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Guardar (Create)'),
          ),
        ],
      ),
    );
  }

  void _deleteCode(int index) {
    setState(() {
      _asocsList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión ASOCS (CRUD)'),
        backgroundColor: const Color(0xFF0A192F),
        foregroundColor: Colors.white,
      ),
      body: _asocsList.isEmpty
          ? const Center(child: Text('No hay códigos registrados.'))
          : ListView.builder(
              itemCount: _asocsList.length,
              itemBuilder: (context, index) {
                final item = _asocsList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.qr_code, color: Color(0xFF0066FF)),
                    title: Text(item['plan'] ?? ''),
                    subtitle: Text('Código: ${item['code']} | Descuento: ${item['discount']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCode(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAsocsCode,
        backgroundColor: const Color(0xFF0066FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}