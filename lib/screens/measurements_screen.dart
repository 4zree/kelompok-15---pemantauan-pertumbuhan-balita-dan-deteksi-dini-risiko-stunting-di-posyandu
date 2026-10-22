import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Pengukuran', style: TextStyle(fontWeight: FontWeight.w800)),
            backgroundColor: AppTheme.background,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Catat pertumbuhan si kecil dengan teliti.', style: TextStyle(color: AppTheme.textSecondary, height: 1.4)),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppTheme.lavender, borderRadius: BorderRadius.circular(22)),
                  child: const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.white, radius: 25, child: Icon(Icons.straighten_rounded, color: Color(0xFF6955B8), size: 27)),
                      SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Pengukuran rutin', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF51418E))), SizedBox(height: 4), Text('Siapkan data berat badan, panjang/tinggi badan, dan tanggal pengukuran.', style: TextStyle(color: AppTheme.textSecondary, height: 1.4, fontSize: 12))])),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.border)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Icon(Icons.monitor_weight_rounded, size: 30, color: AppTheme.primary), SizedBox(width: 10), Expanded(child: Text('Form pengukuran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)))]),
                      SizedBox(height: 12),
                      Text('Rencana isian', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                      SizedBox(height: 10),
                      _PlanRow(icon: Icons.child_care_rounded, text: 'Pilih data balita'),
                      _PlanRow(icon: Icons.calendar_month_rounded, text: 'Tanggal pengukuran'),
                      _PlanRow(icon: Icons.scale_rounded, text: 'Berat badan (kg)'),
                      _PlanRow(icon: Icons.height_rounded, text: 'Panjang/tinggi badan (cm)'),
                      SizedBox(height: 12),
                      Divider(),
                      SizedBox(height: 8),
                      Text('Catatan penting', style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
                      SizedBox(height: 5),
                      Text('Form input, penyimpanan, dan perhitungan z-score WHO belum aktif pada versi UI ini. Aplikasi belum menghasilkan klasifikasi status gizi.', style: TextStyle(color: AppTheme.textSecondary, height: 1.45, fontSize: 12)),
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

class _PlanRow extends StatelessWidget {
  const _PlanRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Row(children: [Icon(icon, size: 19, color: AppTheme.primary), const SizedBox(width: 10), Expanded(child: Text(text, style: const TextStyle(color: AppTheme.textSecondary)))]),
    );
  }
}
