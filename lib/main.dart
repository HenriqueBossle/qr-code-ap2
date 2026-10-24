import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  bool _readingTicket = false;
  bool _checkInDone = false;
  String _scanResult = '';
  bool _scanHandled = false;
  
  List<String> listPeople = [];

  String dataQrCode = "";

  void _onDetect(BarcodeCapture capture) {
    if (_scanHandled) return;

    if (capture.barcodes.isEmpty) return;

    final barcode = capture.barcodes.first;
    final code = barcode.rawValue;

    if (code == null) return;

    setState(() {
      _scanHandled = true;
      _scanResult = code;
      _readingTicket = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
        
      ),
      body: Center(
        child: _readingTicket ? Column(
          children: [
            if (_readingTicket)
              Column(
                children: [
                  const Text('Aponte a câmera para o QR Code'),

                  Expanded(
                    child: MobileScanner(
                      onDetect: _onDetect,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _readingTicket = false;
                        _scanHandled = false;
                      });
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              )
          ]
        ) : 
        SingleChildScrollView( 
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
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty ? null : () {
                setState(() {
                   _generateTicket = true;
                    dataQrCode = 'CHECKIN|${_nameController.text.trim()}|${_emailController.text.trim()}';
                });
            },
            child: const Text('Gerar QRCode'),
            ),
            const SizedBox(height: 16),
            if (_generateTicket)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network('https://images.squarespace-cdn.com/content/v1/58d09402db29d660e4781a57/1759526539438-G6NB2WWX7FG87EBUT6L6/_Sanchez_Danny_LA_COMIC_CON-13.jpg?format=1000w',   width: 350,),
                    Text('Nome: ${_nameController.text}'),
                    Text('E-mail: ${_emailController.text}'),
                    Text('Parabens você deu o primeiro passo no cadastro!'),
                    Text('Agora leia o QRCode para terminar o Check-In'),
                    if(!dataQrCode.isEmpty) QrImageView(data: dataQrCode, size: 200),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        _readingTicket = true;
                        _scanHandled = false;
                        _scanResult = '';
                      });
                    },
                    child: const Text('Ler QRCode de outro dispositivo'),)
                  ],
                  
                ),

                
                
              ),
            ),
          ],

          
        )
        ),
      ),
      
    );
  }
}
