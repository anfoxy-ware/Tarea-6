import 'package:flutter/material.dart'; // Paquete para crear la interfaz de usuario
import 'package:http/http.dart' as http; // Paquete para realizar solicitudes HTTP
import 'dart:convert'; // Para trabajar con JSON

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String latitude = '18.4861'; // Latitud de Santo Domingo
  String longitude = '-69.9312'; // Longitud de Santo Domingo
  Map<String, dynamic>? weatherData; // Variable para almacenar los datos del clima

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // Llama a la función para obtener datos del clima
  }

  Future<void> fetchWeatherData() async {
    // Crea la URL de la API de Open Meteo con los parámetros necesarios
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=America/Santo_Domingo',
    );

    // Realiza una solicitud GET a la API
    final response = await http.get(url);

    // Verifica si la respuesta fue exitosa (código 200)
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body); // Decodifica y almacena los datos del clima
      });
    } else {
      // Manejo de errores en caso de que la solicitud falle
      print('Error al obtener los datos del clima: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronóstico del Clima - Santo Domingo'), // Título de la barra de aplicaciones
      ),
      body: Center(
        child: weatherData == null // Verifica si los datos del clima no están disponibles
            ? CircularProgressIndicator() // Muestra un indicador de carga mientras se obtienen los datos
            : Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
                children: [
                  Text(
                    'Clima para mañana', // Título del pronóstico
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20), // Espacio entre el título y los datos
                  if (weatherData != null) ...[ // Verifica si hay datos del clima
                    // Muestra la temperatura máxima y mínima de mañana
                    Text(
                      'Temperatura máxima: ${weatherData!['daily']['temperature_2m_max'][1]}°C', // Temperatura máxima
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Temperatura mínima: ${weatherData!['daily']['temperature_2m_min'][1]}°C', // Temperatura mínima
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Precipitación: ${weatherData!['daily']['precipitation_sum'][1]} mm', // Precipitación
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
