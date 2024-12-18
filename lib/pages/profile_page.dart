import 'package:flutter/material.dart';
import 'package:piscine_mobile_4/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// import 'logout_button.dart';
// import '../authentications/google_authen.dart';

// Pantalla 2
class ProfilePage extends StatefulWidget{
	const ProfilePage({super.key});
	@override
	State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {

	@override
	Widget build(BuildContext context) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Text('Pág.2 - User: ${FirebaseAuth.instance.currentUser?.displayName ?? ''}', textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'DancingScript',fontSize: 24, color: Colors.black),),

					Expanded(
					child: StreamBuilder<List<Map<String, dynamic>>>(
						stream: getNotesStream(), // Usamos el Stream aquí
						builder: (context, snapshot) {
							if (snapshot.connectionState == ConnectionState.waiting) {
								return const Center(child: CircularProgressIndicator());
							} else if (snapshot.hasError) {
								return Center(
									child: Text('Error: ${snapshot.error}'),
								);
							} else if (!snapshot.hasData || snapshot.data!.isEmpty) {
								return const Center(child: Text('No hay datos disponibles'));
							}

							final notes = snapshot.data!;
							return ListView.builder(
								itemCount: notes.length,
								itemBuilder: (context, index) {

									final note = notes[index];
									final Timestamp? timestamp = note['date'];
									final DateTime? dateTime = timestamp?.toDate();
									final String day = dateTime != null ? DateFormat('dd').format(dateTime) : '--';
									final String month = dateTime != null ? DateFormat('MMM').format(dateTime) : '--';
									final String year = dateTime != null ? DateFormat('yyyy').format(dateTime) : '--';

									final String moodText = note['icon'] ?? 'neutral';
									final String emoji = moodEmojis[moodText] ?? '?';

									return Padding(
										padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaciado entre elementos
											children: <Widget>[
												Column(
												  children: [
												    Text(
												    	day,
												    	style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
												    ),
														Text(
															month,
															style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
															),
														Text(
															year,
															style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
															),
												  ],
												),
												Text(
													emoji,
													style: const TextStyle(fontSize: 20, color: Colors.grey),
												),
												Text(
													note['title'],
													style: const TextStyle(fontSize: 14, color: Colors.grey),
												),
												// Text(
												// 	'ID: ${note['uid']}',
												// 	style: const TextStyle(fontSize: 14, color: Colors.grey),
												// ),
											],
										),
									);
								},
							);
						},
					),
				),

					ElevatedButton(
						onPressed: () {
							// Llamamos al callback para cambiar a Pantalla 0
							(context.findAncestorStateOfType<PantallaPrincipalState>()!)
									.cambiarPantalla(0);
						},
						child: const Text('Ir a Pantalla Welcome'),
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.center, // Centrar los iconos en la fila
						children: [
							IconButton(
								onPressed: () {
									// Lógica para el primer icono
									(context.findAncestorStateOfType<PantallaPrincipalState>()!)
											.cambiarPantalla(0);
								},
								icon: const Icon(Icons.person),
								tooltip: 'Ir a Pantalla Usuario', // Tooltip que aparece al pasar el mouse
								color: Colors.blue, // Color del icono
								iconSize: 32.0, // Tamaño del icono
							),
							const SizedBox(width: 16), // Separación entre los iconos
							IconButton(
								onPressed: () {
									// Lógica para el segundo icono
									(context.findAncestorStateOfType<PantallaPrincipalState>()!)
											.cambiarPantalla(1);
								},
								icon: const Icon(Icons.calendar_today),
								tooltip: 'Ir a Pantalla Calendario', // Tooltip para el segundo icono
								color: Colors.green,
								iconSize: 32.0,
							),
						],

					  // children: [
					  //   ElevatedButton(
					  //   	onPressed: () {
					  //   		// Llamamos al callback para cambiar a Pantalla 1
					  //   		(context.findAncestorStateOfType<PantallaPrincipalState>()!)
					  //   				.cambiarPantalla(1);
					  //   	},
					  //   	child: const Text('Ir a Pantalla 1 (Log con Google/Github)'),
					  //   ),
					  // ],
					),
				],
			),
		);
	}

	// Devuelve un Stream que emite una lista de mapas con los datos en tiempo real
	Stream<List<Map<String, dynamic>>> getNotesStream() {
		return FirebaseFirestore.instance
				.collection('notes') // Cambia 'notes' si necesitas otra colección
				.snapshots()
				.map((snapshot) => snapshot.docs.map((doc) {
							return {
								'title': doc.data()['title'] ?? 'Sin título',
								'uid': doc.id,
								'icon': doc.data()['icon'] ?? 'Sin icono',
								'date': doc.data()['date'],
							};
						}).toList());
	}
}

const Map<String, String> moodEmojis = {
  'happy': '😊',
  'sad': '😢',
  'angry': '😡',
  'excited': '🤩',
  'nervous': '😬',
  'neutral': '😐',
  // Agrega más estados y emojis según sea necesario
};
