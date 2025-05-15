import 'package:flutter/material.dart';

class FormSubKategoriSampah extends StatefulWidget {
  final String? initialCategory;
  final bool isDropdownEnabled;
  final List<String> existingSubCategories;
  final Function(String subCategory, String category) onSubmit;

  const FormSubKategoriSampah({
    Key? key,
    this.initialCategory,
    this.isDropdownEnabled = true,
    required this.existingSubCategories,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<FormSubKategoriSampah> createState() => _FormSubKategoriSampahState();
}

class _FormSubKategoriSampahState extends State<FormSubKategoriSampah> {
  final TextEditingController _subKategoriController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedKategori;

  @override
  void initState() {
    super.initState();
    _selectedKategori = widget.initialCategory;
  }

  @override
  void dispose() {
    _subKategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // Prevent resizing when keyboard appears
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Form Sub Kategori Sampah',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Nama Sub Kategori Sampah',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _subKategoriController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama sub kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama sub kategori harus diisi';
                    }
                    
                    // Check if sub category already exists
                    if (widget.existingSubCategories.any(
                        (item) => item.toLowerCase() == value.toLowerCase())) {
                      return 'Sub kategori ini sudah ada';
                    }
                    
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kategori Sampah',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                widget.isDropdownEnabled 
                  ? _buildSelectableDropdown()
                  : _buildNonSelectableField(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A5AEB),
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                          _subKategoriController.text, 
                          _selectedKategori ?? widget.initialCategory ?? 'Sampah Anorganik'
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Tambah Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Color(0xFF0A5AEB),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectableDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedKategori,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Pilih Kategori Sampah',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          borderRadius: BorderRadius.circular(8),
          items: ['Sampah Anorganik', 'Sampah Organik']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedKategori = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildNonSelectableField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF5F5F5), // Light gray to indicate non-editable
      ),
      child: Text(
        _selectedKategori ?? widget.initialCategory ?? '',
        style: const TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  }
}

// Function to show the form dialog
Future<void> showFormSubKategoriSampah({
  required BuildContext context,
  required String? initialCategory,
  required bool isDropdownEnabled,
  required List<String> existingSubCategories,
  required Function(String subCategory, String category) onSubmit,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FormSubKategoriSampah(
        initialCategory: initialCategory,
        isDropdownEnabled: isDropdownEnabled,
        existingSubCategories: existingSubCategories,
        onSubmit: onSubmit,
      );
    },
  );
}