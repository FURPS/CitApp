import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Image.asset('assets/logo-dental.png', width: 100),
            const SizedBox(height: 40),
            
            // Tabs
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isLogin = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _isLogin ? const Color(0xFF0d6efd) : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isLogin ? const Color(0xFF0d6efd) : Colors.grey,
                          fontWeight: _isLogin ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isLogin = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: !_isLogin ? const Color(0xFF0d6efd) : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Registrarse',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_isLogin ? const Color(0xFF0d6efd) : Colors.grey,
                          fontWeight: !_isLogin ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            _isLogin ? _buildLoginForm() : _buildRegisterForm(),

            const SizedBox(height: 20),
            const Text('o', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Social Login
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_mobiledata, size: 24),
                  SizedBox(width: 10),
                  Text('Continuar con Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su email';
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ingrese su contraseña';
              return null;
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value!),
              ),
              const Text('Recordarme'),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0d6efd),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Ingresar', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nombre completo',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Correo electrónico',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Teléfono',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Confirmar contraseña',
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0d6efd),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Registrarse', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }
}
