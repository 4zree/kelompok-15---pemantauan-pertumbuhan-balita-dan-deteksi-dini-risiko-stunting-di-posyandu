
import 'package:flutter_test/flutter_test.dart';
import 'package:kadercek/app.dart';

void main() {
  testWidgets('KaderCek langsung membuka Beranda tanpa login', (
    tester,
  ) async {
    await tester.pumpWidget(const KaderCekApp());

    expect(find.text('KaderCek'), findsOneWidget);
    expect(find.text('Ringkasan Posyandu'), findsOneWidget);
    expect(find.text('Masuk'), findsNothing);
    expect(find.text('Login'), findsNothing);
  });

  testWidgets('bottom navigation membuka menu Data Balita', (
    tester,
  ) async {
    await tester.pumpWidget(const KaderCekApp());

    await tester.tap(find.text('Data Balita').last);
    await tester.pumpAndSettle();

    // Pastikan halaman Data Balita terbuka.
    expect(find.text('Data Balita'), findsWidgets);
    expect(find.text('Cari nama balita'), findsOneWidget);
    expect(find.text('Tambah balita'), findsOneWidget);
  });
}
