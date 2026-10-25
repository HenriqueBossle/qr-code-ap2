import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcodeap2/main.dart';

void main() {
  testWidgets('generates a ticket after entering attendee details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Gerar QRCode'), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull,
    );

    await tester.enterText(find.byType(TextField).at(0), 'Ada Lovelace');
    await tester.enterText(find.byType(TextField).at(1), 'ada@example.com');
    await tester.pump();

    await tester.tap(find.text('Gerar QRCode'));
    await tester.pump();

    expect(find.text('Nome: Ada Lovelace'), findsOneWidget);
    expect(find.text('E-mail: ada@example.com'), findsOneWidget);
    expect(
      find.text('Agora leia o QRCode para terminar o Check-In'),
      findsOneWidget,
    );
  });

  testWidgets('shows the camera and adds a valid scan to the confirmed list', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField).at(0), 'Ada Lovelace');
    await tester.enterText(find.byType(TextField).at(1), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Gerar QRCode'));
    await tester.pump();
    await tester.ensureVisible(find.text('Ler QRCode de outro dispositivo'));
    await tester.tap(find.text('Ler QRCode de outro dispositivo'));
    await tester.pump();

    expect(find.text('Aponte a câmera para o QR Code'), findsOneWidget);
    expect(find.byType(MobileScanner), findsOneWidget);
    expect(tester.takeException(), isNull);

    tester.widget<MobileScanner>(find.byType(MobileScanner)).onDetect!(
      const BarcodeCapture(
        barcodes: [Barcode(rawValue: 'CHECKIN|Ada Lovelace|ada@example.com')],
      ),
    );
    await tester.pump();

    expect(find.byType(MobileScanner), findsNothing);
    expect(find.text('Lista de 1 itens'), findsOneWidget);
    expect(
      find.text('QR Code lido: CHECKIN|Ada Lovelace|ada@example.com'),
      findsOneWidget,
    );
  });
}
