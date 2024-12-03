import 'package:flutter/material.dart';
import 'package:piscine_mobile_4/main.dart';

// Pantalla 0 - WELCOME
class Welcome extends StatelessWidget {
  const Welcome({super.key});


  @override
  Widget build(BuildContext context) {
    // Se pasa el callback al construir la pantalla
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondoPantalla.jpg'), // Asegúrate de tener la imagen en esta ruta
            fit: BoxFit.cover, // Esto asegura que la imagen cubra toda la pantalla
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text('Welcome to your\nDiary', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'DancingScript',fontSize: 24, color: Colors.black),),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Llamamos al callback para cambiar a Pantalla 1
                  (context.findAncestorStateOfType<PantallaPrincipalState>()!)
                      .cambiarPantalla(1);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: const Text('Login', style:TextStyle(fontFamily: 'DancingScript', color: Colors.white, fontSize: 22)),
              ),
            ]
          ),
        )
      )
    );
  }
}