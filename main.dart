import 'package:flutter/material.dart'; // Paquete para crear la interfaz de usuario
import 'screens/gender_prediction_screen.dart'; // Pantalla para predicción de género
import 'screens/age_prediction_screen.dart'; // Pantalla para predicción de edad
import 'screens/universities_screen.dart'; // Pantalla para mostrar universidades
import 'screens/weather_screen.dart'; // Pantalla del clima
import 'screens/news_screen.dart'; // Pantalla de noticias
import 'screens/about_screen.dart'; // Pantalla "Acerca de"

void main() {
  runApp(MyApp()); // Inicia la aplicación
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Herramienta de Predicción', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color primario de la aplicación
      ),
      home: HomeScreen(), // Pantalla principal al iniciar la aplicación
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Índice para la pantalla seleccionada

  // Lista de widgets que representan cada pantalla
  static final List<Widget> _widgetOptions = <Widget>[
    HomeView(),                 // Pantalla principal con la caja de herramientas
    GenderPredictionScreen(),   // Pantalla de predicción de género
    AgePredictionScreen(),      // Pantalla de predicción de edad
    UniversitiesScreen(),       // Pantalla de universidades
    WeatherScreen(),            // Pantalla del clima
    NewsScreen(),               // Pantalla de noticias
    AboutScreen(),              // Pantalla "Acerca de"
  ];

  // Cambia el índice seleccionado cuando un ítem es tocado
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Fondo rosado claro
      appBar: AppBar(
        title: Text('Herramienta de Predicción'), // Título en la barra de aplicaciones
        backgroundColor: Colors.pink[300], // Color de fondo de la barra de aplicaciones
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Muestra la pantalla seleccionada
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink[100], // Color de fondo de la barra de navegación
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service), // Icono de caja de herramientas
            label: 'Inicio', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), // Icono para la pantalla de predicción de género
            label: 'Género', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake), // Icono para la pantalla de predicción de edad
            label: 'Edad', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school), // Icono para la pantalla de universidades
            label: 'Universidades', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny), // Icono para la pantalla del clima
            label: 'Clima', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article), // Icono para la pantalla de noticias
            label: 'Noticias', // Texto del ítem
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info), // Icono para la pantalla "Acerca de"
            label: 'Acerca de', // Texto del ítem
          ),
        ],
        currentIndex: _selectedIndex, // Índice actualmente seleccionado
        selectedItemColor: Colors.pink[800], // Color del ítem seleccionado
        unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
        onTap: _onItemTapped, // Llama a la función al tocar un ítem
      ),
    );
  }
}

// Crear una pantalla de inicio que muestre la caja de herramientas
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
      children: [
        // Carga la imagen desde una URL
        Image.network(
          'https://cdn-icons-png.freepik.com/512/5460/5460163.png', // URL de la imagen
          width: 200, // Ancho de la imagen
          height: 200, // Altura de la imagen
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 50); // Muestra un ícono de error si no se puede cargar la imagen
          },
        ),
        SizedBox(height: 20), // Espacio entre la imagen y el texto
        Text(
          'Bienvenido a la Herramienta de Predicción', // Mensaje de bienvenida
          style: TextStyle(fontSize: 24, color: Colors.pink[800]), // Estilo del texto
          textAlign: TextAlign.center, // Alineación del texto
        ),
        SizedBox(height: 20), // Espacio entre los textos
        Text(
          'Elige una opción en la barra inferior para comenzar.', // Instrucción para el usuario
          style: TextStyle(fontSize: 16, color: Colors.grey[800]), // Estilo del texto
          textAlign: TextAlign.center, // Alineación del texto
        ),
      ],
    );
  }
}
