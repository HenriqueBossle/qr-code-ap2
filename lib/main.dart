import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'home_screen.dart';
import 'leitor_qr_screen.dart';
import 'confirmed_list_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 150, 140, 8),
        ),
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
  bool _scanHandled = false;
  final List<String> _confirmedList = [];

  String _scanResult = '';
  String _dataQrCode = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanHandled || capture.barcodes.isEmpty) return;

    final code = capture.barcodes.first.rawValue;
    if (code == null) return;

    final parts = code.split('|');
    if (parts.length != 3 ||
        parts[0] != 'CHECKIN' ||
        parts[1].trim().isEmpty ||
        parts[2].trim().isEmpty) {
      return;
    }

    setState(() {
      _scanHandled = true;
      _scanResult = code;
      _readingTicket = false;
      _confirmedList.add(parts[1]);
    });
  }

  void _startReadingTicket() {
    setState(() {
      _readingTicket = true;
      _scanHandled = false;
      _scanResult = '';
    });
  }

  void _cancelReadingTicket() {
    setState(() {
      _readingTicket = false;
      _scanHandled = false;
    });
  }

  void _generateTicketCode() {
    setState(() {
      _generateTicket = true;
      _dataQrCode =
          'CHECKIN|${_nameController.text.trim()}|${_emailController.text.trim()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: _readingTicket
                ? LeitorQrScreen(
                    onDetect: _onDetect,
                    onCancel: _cancelReadingTicket,
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        HomeScreen(
                          nameController: _nameController,
                          emailController: _emailController,
                          generateTicket: _generateTicket,
                          dataQrCode: _dataQrCode,
                          scanResult: _scanResult,
                          onFormChanged: () => setState(() {}),
                          onGenerateTicket: _generateTicketCode,
                          onStartReadingTicket: _startReadingTicket,
                        ),
                        if (_confirmedList.isNotEmpty)
                          ConfirmedListScreen(list: _confirmedList),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
