import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Paquete para hacer solicitudes HTTP
import 'dart:convert'; // Para trabajar con JSON

class AgePredictionScreen extends StatefulWidget {
  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  final TextEditingController _nameController = TextEditingController(); // Controlador para el campo de texto
  int? _age; // Variable para almacenar la edad predicha
  String _ageStatus = ''; // Estado de la edad (joven, adulto, anciano)
  String? _imageUrl; // URL de la imagen según la edad

  void _predictAge() async {
    // Función para predecir la edad
    final response = await http.get(Uri.parse('https://api.agify.io/?name=${_nameController.text}')); // Llamada a la API
    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Decodifica la respuesta JSON
      setState(() {
        _age = data['age']; // Almacena la edad recibida
        if (_age != null) {
          // Determina el estado y la imagen según la edad
          if (_age! < 30) {
            _ageStatus = 'Joven';
            _imageUrl = 'https://png.pngtree.com/png-clipart/20230219/original/pngtree-young-man-avatar-png-image_8959709.png'; // Imagen para jóvenes
          } else if (_age! < 60) {
            _ageStatus = 'Adulto';
            _imageUrl = 'https://png.pngtree.com/png-clipart/20231001/original/pngtree-3d-illustration-avatar-profile-man-png-image_13026634.png'; // Imagen para adultos
          } else {
            _ageStatus = 'Anciano';
            _imageUrl = 'https://png.pngtree.com/png-clipart/20230815/original/pngtree-old-man-portrait-person-profile-picture-image_7978204.png'; // Imagen para ancianos
          }
        }
      });
    } else {
      setState(() {
        _age = null; // Resetea la edad si hay un error en la respuesta
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'), // Título de la pantalla
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController, // Controlador para el campo de texto
              decoration: InputDecoration(labelText: 'Ingresa un nombre'), // Etiqueta del campo
            ),
            SizedBox(height: 20), // Espacio entre el campo de texto y el botón
            ElevatedButton(
              onPressed: _predictAge, // Acción al presionar el botón
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20), // Espacio entre el botón y el resultado
            if (_age != null) // Muestra el resultado solo si la edad no es nula
              Column(
                children: [
                  Text(
                    'Edad: $_age - Estado: $_ageStatus', // Muestra la edad y el estado
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20), // Espacio antes de la imagen
                  // Mostrar imagen según la edad
                  if (_imageUrl != null)
                    Image.network(
                      _imageUrl!,
                      height: 150, // Ajustar el tamaño de la imagen según sea necesario
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
