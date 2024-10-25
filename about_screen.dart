import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de Mí'), // Título de la pantalla
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Carga tu foto desde una URL
            Image.network(
              'https://media.licdn.com/dms/image/D5603AQFWi5HMYzVT6A/profile-displayphoto-shrink_200_200/0/1719270654784?e=2147483647&v=beta&t=GvmHKsKxfpizZrfv2tYe5M1mnPldTR98qEo-Zhwtg-A',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 50); // Muestra un ícono de error si no se puede cargar la imagen
              },
            ),
            SizedBox(height: 20), // Espacio entre la imagen y el texto
            Text(
              'Frandy Daniel de la Cruz Arias', // Tu nombre
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10), // Espacio entre el nombre y el correo
            Text(
              'frandy9991@gmail.com', // Tu correo
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10), // Espacio entre el correo y el teléfono
            Text(
              'Teléfono: +1849-253.2598', // Tu número de teléfono
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10), // Espacio antes de la descripción
            Text(
              'Desarrollador de Software', // Breve descripción
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
