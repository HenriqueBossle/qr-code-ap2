import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      debugShowCheckedModeBanner: false,
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

  bool _generateTicket = false;

  String dataQrCode = "";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
        
      ),
      body: Center(
        child: SingleChildScrollView( 
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
                   _generateTicket = true;
                    dataQrCode = 'CHECKIN|${_nameController.text.trim()}|${_emailController.text.trim()}';
                });
            },
            child: const Text('Gerar QRCode'),
            ),
            if (_generateTicket)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network('https://images.squarespace-cdn.com/content/v1/58d09402db29d660e4781a57/1759526539438-G6NB2WWX7FG87EBUT6L6/_Sanchez_Danny_LA_COMIC_CON-13.jpg?format=1000w',   width: 350,
  ),
                    Text('Nome: ${_nameController.text}'),
                    Text('E-mail: ${_emailController.text}'),
                    Text('Parabens você deu o primeiro passo no cadastro!'),
                    Text('Agora leia o QRCode para terminar o Check-In'),
                    if(!dataQrCode.isEmpty) QrImageView(data: dataQrCode, size: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
        )
      ),
      
    );
  }
}
