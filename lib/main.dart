import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'home_screen.dart';
import 'leitor_qr_screen.dart';
import 'confirmed_list_screen.dart';

const _primaryColor = Color(0xFF5B4BDB);
const _accentColor = Color(0xFFFFB547);
const _backgroundColor = Color(0xFFF6F7FB);
const _textColor = Color(0xFF20243A);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: _primaryColor,
          brightness: Brightness.light,
        ).copyWith(
          primary: _primaryColor,
          secondary: _accentColor,
          surface: Colors.white,
          onSurface: _textColor,
        );

    return MaterialApp(
      title: 'Cadastro Comic Con',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: _backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: _backgroundColor,
          foregroundColor: _textColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: _textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineSmall: const TextStyle(
            color: _textColor,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
          titleLarge: const TextStyle(
            color: _textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: const TextStyle(
            color: _textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: const TextStyle(
            color: _textColor,
            fontSize: 16,
            height: 1.5,
          ),
          bodyMedium: const TextStyle(
            color: Color(0xFF656A7D),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E5EF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2E5EF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _primaryColor, width: 1.5),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFFE7E8EF),
            disabledForegroundColor: const Color(0xFF9296A6),
            minimumSize: const Size.fromHeight(52),
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE9EAF1)),
          ),
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
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.confirmation_number_outlined,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(child: Text(widget.title)),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: _readingTicket
            ? LeitorQrScreen(
                onDetect: _onDetect,
                onCancel: _cancelReadingTicket,
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        if (_confirmedList.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          ConfirmedListScreen(list: _confirmedList),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
