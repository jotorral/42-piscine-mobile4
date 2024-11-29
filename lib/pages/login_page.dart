import 'package:flutter/material.dart';
import 'package:piscine_mobile_4/main.dart';
import 'package:piscine_mobile_4/authentications/google_authen.dart';


// Pantalla 1 - LOGIN
class Login extends StatelessWidget {
	const Login({super.key});


	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
						const GoogleAuthen(),

/*					ElevatedButton(						
						onPressed: () {
							// Llamamos al callback para cambiar a Pantalla 1
							(context.findAncestorStateOfType<PantallaPrincipalState>()!)
									.cambiarPantalla(2);
						},
						child: const Text('Ir a Pantalla 2'), // métodos firebase_auth y google_sign_in para Google
					),*/
					ElevatedButton(
						onPressed: () {
							// Llamamos al callback para cambiar a Pantalla 3
							(context.findAncestorStateOfType<PantallaPrincipalState>()!)
									.cambiarPantalla(2);
						},
						child: const Text('Ir a Pantalla 2'),
					),
					ElevatedButton(
						onPressed: () {
							// Llamamos al callback para cambiar a Pantalla 3
							(context.findAncestorStateOfType<PantallaPrincipalState>()!)
									.cambiarPantalla(0);
						},
						child: const Text('Volver a Pantalla Welcome'),
					),
				],
			),
		);
	}
}
