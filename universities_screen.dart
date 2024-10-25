import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Paquete para realizar solicitudes HTTP
import 'dart:convert'; // Para trabajar con JSON
import 'package:url_launcher/url_launcher.dart'; // Para abrir enlaces en el navegador

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  List<dynamic> _universities = []; // Lista para almacenar universidades
  String _errorMessage = ''; // Mensaje de error si ocurre algún problema
  final TextEditingController _countryController = TextEditingController(); // Controlador para el campo de texto

  Future<void> fetchUniversities(String country) async {
    try {
      // Realiza una solicitud GET a la API de universidades
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body); // Decodifica la respuesta JSON
        setState(() {
          _universities = data; // Almacena la lista de universidades
          _errorMessage = ''; // Limpia el mensaje de error
        });
      } else {
        // Manejo de errores si la respuesta no es 200
        setState(() {
          _errorMessage = 'Error al cargar universidades. Intente nuevamente.'; // Mensaje de error
        });
      }
    } catch (e) {
      // Captura errores de conexión
      setState(() {
        _errorMessage = 'Error de conexión. Verifique su internet.'; // Mensaje de error
      });
    }
  }

  void _onSearchPressed() {
    String country = _countryController.text; // Obtiene el texto ingresado
    if (country.isNotEmpty) {
      fetchUniversities(country); // Llama a la función para obtener universidades del país ingresado
    } else {
      // Maneja el caso en que no se ingresa un país
      setState(() {
        _errorMessage = 'Por favor, ingrese un nombre de país.'; // Mensaje de error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Universidades')), // Título de la barra de aplicaciones
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaciado alrededor del contenido
        child: Column(
          children: [
            TextField(
              controller: _countryController, // Controlador del campo de texto
              decoration: InputDecoration(
                labelText: 'Ingresa el nombre del país en inglés', // Etiqueta del campo
                border: OutlineInputBorder(), // Borde del campo
              ),
            ),
            SizedBox(height: 10), // Espacio entre el campo y el botón
            ElevatedButton(
              onPressed: _onSearchPressed, // Llama a la función al presionar el botón
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20), // Espacio entre el botón y el contenido de la lista
            _errorMessage.isNotEmpty // Verifica si hay un mensaje de error
                ? Center(child: Text(_errorMessage)) // Muestra el mensaje de error
                : Expanded(
                    child: ListView.builder(
                      itemCount: _universities.length, // Número de universidades en la lista
                      itemBuilder: (context, index) {
                        final university = _universities[index]; // Obtiene la universidad actual
                        return Card(
                          child: ListTile(
                            title: Text(university['name']), // Nombre de la universidad
                            subtitle: Text(university['domains'][0]), // Dominio de la universidad
                            trailing: TextButton(
                              onPressed: () {
                                launch(university['web_pages'][0]); // Abre el enlace en el navegador
                              },
                              child: Text('Visitar'), // Texto del botón
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
