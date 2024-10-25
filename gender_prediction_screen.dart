import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Paquete para realizar solicitudes HTTP
import 'dart:convert'; // Para trabajar con JSON

class GenderPredictionScreen extends StatefulWidget {
  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  final TextEditingController _nameController = TextEditingController(); // Controlador para el campo de texto
  String? _gender; // Variable para almacenar el género predicho

  void _predictGender() async {
    // Función para predecir el género
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=${_nameController.text}')); // Llamada a la API
    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Decodifica la respuesta JSON
      setState(() {
        _gender = data['gender']; // Almacena el género recibido
      });
    } else {
      setState(() {
        _gender = 'Error en la predicción'; // Manejo de errores
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determina el color de fondo según el género
    Color backgroundColor;
    if (_gender == 'male') {
      backgroundColor = Colors.blue; // Fondo azul para masculino
    } else if (_gender == 'female') {
      backgroundColor = Colors.pink; // Fondo rosado para femenino
    } else {
      backgroundColor = Colors.white; // Fondo blanco por defecto si no hay género
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'), // Título de la pantalla
      ),
      body: Container(
        color: backgroundColor, // Aplica el color de fondo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController, // Controlador para el campo de texto
              decoration: InputDecoration(labelText: 'Ingresa un nombre'), // Etiqueta del campo
            ),
            SizedBox(height: 20), // Espacio entre el campo de texto y el botón
            ElevatedButton(
              onPressed: _predictGender, // Acción al presionar el botón
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20), // Espacio entre el botón y el resultado
            if (_gender != null) // Muestra el resultado solo si el género no es nulo
              Text(
                'Género: ${_gender == "male" ? "Masculino" : "Femenino"}', // Muestra el género predicho
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
