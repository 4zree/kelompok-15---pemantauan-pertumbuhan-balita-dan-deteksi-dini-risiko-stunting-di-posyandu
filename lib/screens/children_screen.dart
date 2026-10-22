import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../models/child.dart';
import '../theme/app_theme.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  final _searchController = TextEditingController();
  List<Child> _children = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadChildren();
    _searchController.addListener(_loadChildren);
  }

  @override
  void dispose() {
    _searchController.removeListener(_loadChildren);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadChildren() async {
    try {
      final rows = await AppDatabase.instance.getChildren(query: _searchController.text);
      if (!mounted) return;
      setState(() {
        _children = rows;
        _loading = false;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Data belum dapat dibaca. Coba tutup dan buka kembali aplikasi.';
      });
    }
  }

  Future<void> _openForm({Child? child}) async {
    final saved = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ChildFormDialog(child: child),
    );
    if (saved == true) {
      await _loadChildren();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(child == null ? 'Data balita berhasil disimpan.' : 'Data balita berhasil diperbarui.')),
      );
    }
  }

  Future<void> _deleteChild(Child child) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus data balita?'),
        content: Text('Data ${child.name} akan dihapus dari perangkat. Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Batal')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true || child.id == null) return;
    try {
      await AppDatabase.instance.deleteChild(child.id!);
      await _loadChildren();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data balita dihapus.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data gagal dihapus.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Tambah balita'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            title: Text('Data Balita', style: TextStyle(fontWeight: FontWeight.w800)),
            backgroundColor: AppTheme.background,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Yuk, kelola data si kecil di Posyandu.', style: TextStyle(color: AppTheme.textSecondary, height: 1.4)),
                const SizedBox(height: 18),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari nama balita',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(icon: const Icon(Icons.close), onPressed: _searchController.clear, tooltip: 'Hapus pencarian'),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppTheme.mint, borderRadius: BorderRadius.circular(22)),
                  child: Row(children: [
                    const Icon(Icons.shield_moon_rounded, size: 32, color: AppTheme.primaryDark),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Tersimpan di perangkat', style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.primaryDark)),
                      const SizedBox(height: 4),
                      Text('${_children.length} data ditampilkan. Data disimpan secara lokal di perangkat Android ini.', style: const TextStyle(color: AppTheme.textSecondary, height: 1.4, fontSize: 12)),
                    ])),
                  ]),
                ),
                const SizedBox(height: 16),
                if (_loading)
                  const Padding(padding: EdgeInsets.all(36), child: Center(child: CircularProgressIndicator()))
                else if (_error != null)
                  _EmptyState(icon: Icons.error_outline_rounded, title: 'Belum dapat memuat data', subtitle: _error!)
                else if (_children.isEmpty)
                  _EmptyState(
                    icon: _searchController.text.isEmpty ? Icons.child_friendly_rounded : Icons.search_off_rounded,
                    title: _searchController.text.isEmpty ? 'Belum ada data balita' : 'Balita tidak ditemukan',
                    subtitle: _searchController.text.isEmpty
                        ? 'Tekan “Tambah balita” untuk mendaftarkan balita pertama.'
                        : 'Coba kata kunci nama yang berbeda.',
                  )
                else
                  ..._children.map(_childCard),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _childCard(Child child) {
    final birthDate = DateTime.parse(child.birthDate);
    final formattedDate = '${birthDate.day.toString().padLeft(2, '0')}/${birthDate.month.toString().padLeft(2, '0')}/${birthDate.year}';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: AppTheme.border)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: child.gender == 'L' ? const Color(0xFFE2EBFF) : const Color(0xFFFFE6DA),
            child: Icon(child.gender == 'L' ? Icons.child_care_rounded : Icons.face_rounded, color: child.gender == 'L' ? const Color(0xFF356AC3) : const Color(0xFFB96A39), size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(child.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
            const SizedBox(height: 5),
            Text('${child.gender == 'L' ? 'Laki-laki' : 'Perempuan'} • Lahir $formattedDate', style: const TextStyle(color: AppTheme.textSecondary, height: 1.35)),
          ])),
          PopupMenuButton<String>(
            tooltip: 'Aksi data balita',
            onSelected: (value) {
              if (value == 'edit') _openForm(child: child);
              if (value == 'delete') _deleteChild(child);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: ListTile(leading: Icon(Icons.edit_outlined), title: Text('Edit'), contentPadding: EdgeInsets.zero)),
              PopupMenuItem(value: 'delete', child: ListTile(leading: Icon(Icons.delete_outline), title: Text('Hapus'), contentPadding: EdgeInsets.zero)),
            ],
          ),
        ]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 22),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.border)),
        child: Column(children: [
          CircleAvatar(radius: 31, backgroundColor: AppTheme.peach, child: Icon(icon, size: 32, color: const Color(0xFFB96A39))),
          const SizedBox(height: 14),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppTheme.textPrimary)),
          const SizedBox(height: 7),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textSecondary, height: 1.45)),
        ]),
      );
}

class _ChildFormDialog extends StatefulWidget {
  const _ChildFormDialog({this.child});
  final Child? child;

  @override
  State<_ChildFormDialog> createState() => _ChildFormDialogState();
}

class _ChildFormDialogState extends State<_ChildFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late DateTime _birthDate;
  late String _gender;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final child = widget.child;
    _nameController = TextEditingController(text: child?.name ?? '');
    _birthDate = child == null ? DateTime.now() : DateTime.parse(child.birthDate);
    _gender = child?.gender ?? 'L';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _birthDate.isAfter(now) ? now : _birthDate,
      firstDate: DateTime(now.year - 5, 1, 1),
      lastDate: now,
      helpText: 'Pilih tanggal lahir',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (selected != null) setState(() => _birthDate = selected);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final date = '${_birthDate.year.toString().padLeft(4, '0')}-${_birthDate.month.toString().padLeft(2, '0')}-${_birthDate.day.toString().padLeft(2, '0')}';
    final child = Child(id: widget.child?.id, name: _nameController.text.trim(), gender: _gender, birthDate: date, createdAt: widget.child?.createdAt);
    try {
      if (widget.child == null) {
        await AppDatabase.instance.insertChild(child);
      } else {
        await AppDatabase.instance.updateChild(child);
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data gagal disimpan. Silakan coba lagi.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = '${_birthDate.day.toString().padLeft(2, '0')}/${_birthDate.month.toString().padLeft(2, '0')}/${_birthDate.year}';
    return AlertDialog(
      title: Text(widget.child == null ? 'Tambah balita' : 'Edit data balita', style: const TextStyle(fontWeight: FontWeight.w800)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Nama lengkap'),
              const SizedBox(height: 7),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                maxLength: 100,
                decoration: const InputDecoration(hintText: 'Contoh: Aisyah Putri', prefixIcon: Icon(Icons.person_outline_rounded), counterText: ''),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Nama wajib diisi.';
                  if (value.trim().length < 2) return 'Nama minimal 2 karakter.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Jenis kelamin'),
              const SizedBox(height: 7),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.wc_rounded)),
                items: const [
                  DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                ],
                onChanged: _saving ? null : (value) { if (value != null) setState(() => _gender = value); },
              ),
              const SizedBox(height: 16),
              const Text('Tanggal lahir'),
              const SizedBox(height: 7),
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _saving ? null : _pickBirthDate,
                child: InputDecorator(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.calendar_month_rounded), suffixIcon: Icon(Icons.expand_more_rounded)),
                  child: Text(dateText),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Pastikan tanggal lahir sesuai dokumen atau catatan Posyandu.', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            ]),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _saving ? null : () => Navigator.of(context).pop(false), child: const Text('Batal')),
        FilledButton.icon(
          onPressed: _saving ? null : _save,
          icon: _saving ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.save_rounded),
          label: Text(_saving ? 'Menyimpan...' : 'Simpan'),
        ),
      ],
    );
  }
}
