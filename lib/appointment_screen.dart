import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _currentStep = 0;
  String? _selectedService;
  DateTime? _selectedDate;
  String? _selectedDentist;
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cita'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _currentStep > 0 
              ? setState(() => _currentStep--) 
              : Navigator.pop(context),
        ),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _cancel,
        steps: [
          Step(
            title: const Text('Servicio'),
            content: _buildServiceStep(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Fecha y Odontólogo'),
            content: _buildDateTimeStep(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Confirmar'),
            content: _buildConfirmationStep(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceStep() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedService,
          decoration: const InputDecoration(labelText: 'Tipo de servicio'),
          items: const [
            DropdownMenuItem(value: 'limpieza', child: Text('Limpieza dental')),
            DropdownMenuItem(value: 'ortodoncia', child: Text('Consulta de ortodoncia')),
          ],
          onChanged: (value) => setState(() => _selectedService = value),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Motivo de la consulta',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDateTimeStep() {
    return Column(
      children: [
        ListTile(
          title: const Text('Fecha'),
          subtitle: Text(_selectedDate != null 
              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
              : 'Seleccionar fecha'),
          onTap: () => _selectDate(context),
        ),
        const Divider(),
        const Text('Odontólogos disponibles', style: TextStyle(fontWeight: FontWeight.bold)),
        _buildDentistCard('Dr. Carlos Pérez', 'Odontólogo General'),
        _buildDentistCard('Dra. Ana Gómez', 'Ortodoncista'),
        const Divider(),
        const Text('Horarios disponibles', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: ['08:00', '09:30', '11:00', '14:00', '15:30'].map((time) {
            return ChoiceChip(
              label: Text(time),
              selected: _selectedTime == time,
              onSelected: (selected) => setState(() => _selectedTime = selected ? time : null),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDentistCard(String name, String specialty) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(backgroundImage: AssetImage('assets/dentist1.jpg')),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(specialty),
        trailing: _selectedDentist == name ? const Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () => setState(() => _selectedDentist = name),
      ),
    );
  }

  Widget _buildConfirmationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resumen de la cita', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _buildSummaryItem('Servicio', _selectedService ?? 'No seleccionado'),
        _buildSummaryItem('Fecha', _selectedDate != null 
            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' 
            : 'No seleccionada'),
        _buildSummaryItem('Odontólogo', _selectedDentist ?? 'No seleccionado'),
        _buildSummaryItem('Hora', _selectedTime ?? 'No seleccionada'),
        const SizedBox(height: 20),
        CheckboxListTile(
          title: const Text('Acepto los términos y condiciones'),
          value: true,
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _confirmAppointment,
          child: const Text('Confirmar Cita'),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _continue() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _confirmAppointment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¡Cita Agendada!'),
        content: const Text('Su cita ha sido agendada exitosamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
