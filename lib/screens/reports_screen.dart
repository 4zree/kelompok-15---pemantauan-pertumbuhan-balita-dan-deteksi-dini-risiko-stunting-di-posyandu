import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Laporan Bulanan', style: TextStyle(fontWeight: FontWeight.w800)),
            backgroundColor: AppTheme.background,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Lihat ringkasan kegiatan Posyandu dalam satu tempat.', style: TextStyle(color: AppTheme.textSecondary, height: 1.4)),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppTheme.yellow, borderRadius: BorderRadius.circular(24)),
                  child: const Row(
                    children: [
                      CircleAvatar(radius: 25, backgroundColor: Colors.white, child: Icon(Icons.calendar_month_rounded, color: Color(0xFF98721B), size: 27)),
                      SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Rekap kegiatan', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF725612))), SizedBox(height: 4), Text('Periode dan isi laporan akan mengikuti data pengukuran yang tersimpan.', style: TextStyle(color: AppTheme.textSecondary, height: 1.4, fontSize: 12))])),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.border)),
                  child: const Column(
                    children: [
                      CircleAvatar(radius: 34, backgroundColor: AppTheme.peach, child: Icon(Icons.insert_chart_rounded, size: 36, color: Color(0xFFB96A39))),
                      SizedBox(height: 14),
                      Text('Laporan belum tersedia', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                      SizedBox(height: 7),
                      Text('Laporan akan dapat dibuat setelah data pengukuran tersedia.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.textSecondary, height: 1.45)),
                      SizedBox(height: 20),
                      _ReportFeature(icon: Icons.filter_alt_rounded, title: 'Filter periode', description: 'Pilih bulan dan rentang tanggal.'),
                      _ReportFeature(icon: Icons.flag_rounded, title: 'Perlu ditindaklanjuti', description: 'Ringkasan akan mengikuti hasil yang tervalidasi.'),
                      _ReportFeature(icon: Icons.picture_as_pdf_rounded, title: 'Ekspor laporan', description: 'PDF dan Excel direncanakan pada iterasi berikutnya.'),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportFeature extends StatelessWidget {
  const _ReportFeature({required this.icon, required this.title, required this.description});
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, size: 21, color: AppTheme.primary), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)), const SizedBox(height: 3), Text(description, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, height: 1.4))]))]),
    );
  }
}
