import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormApiPage(),
    );
  }
}

class FormApiPage extends StatefulWidget {
  const FormApiPage({super.key});

  @override
  State<FormApiPage> createState() => _FormApiPageState();
}

class _FormApiPageState extends State<FormApiPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String responseText = "";

  // -------- POST (SIN API KEY) ----------
  Future<void> sendPost() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "name": nameController.text,
        "email": emailController.text,
      }),
    );

    setState(() {
      responseText = "POST Response:\n${response.body}";
    });
  }

  // -------- GET ----------
  Future<void> sendGet() async {
    final url = Uri.parse("https://reqres.in/api/users/2");

    final response = await http.get(url);

    setState(() {
      responseText = "GET Response:\n${response.body}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form + API (GET & POST)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Campo Nombre
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Campo Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // BOTONES
            ElevatedButton(
              onPressed: sendPost,
              child: const Text("Enviar (POST)"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: sendGet,
              child: const Text("Carregar usuário (GET)"),
            ),

            const SizedBox(height: 25),

            // RESULTADO
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  responseText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
