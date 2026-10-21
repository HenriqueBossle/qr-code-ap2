import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Comic Con',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 150, 140, 8)),
      ),
      home: const MyHomePage(title: 'Cadastro Comic Con'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _nameController,
              onChanged: (value){
                setState(() {});
              },
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
            ),
            TextField(
              controller: _emailController,
                onChanged: (value){
                setState(() {});
              },
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            ),
            ElevatedButton(
              onPressed: _nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty ? null : () {
                setState(() {
                   
                });
            },
            child: const Text('Gerar QRCode'),
            )
          ],
          
        ),
      ),
      
    );
  }
}
