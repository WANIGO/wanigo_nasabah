import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:wanigo_inven/extra/subcategory_form.dart'; // Import the new form

// Mock data model
class WasteItem {
  final String name;
  final String category;
  final String subCategory;
  final double price;
  final String? imagePath;

  WasteItem({
    required this.name,
    required this.category,
    required this.subCategory,
    required this.price,
    this.imagePath,
  });
}

// Mock subcategories
final List<String> keringSubCategories = [
  'Kertas',
  'Kardus',
  'Plastik',
  'Botol Plastik',
  'Kaleng',
  'Logam',
  'Kaca',
];

final List<String> basahSubCategories = [
  'Sisa Makanan',
  'Sayuran',
  'Buah-buahan',
  'Daun',
  'Ranting',
];

class FormItemSampahScreen extends StatefulWidget {
  final Function(WasteItem)? onItemAdded;
  final String? defaultCategory;
  final bool isDropdownEnabled;
  
  const FormItemSampahScreen({
    Key? key,
    this.onItemAdded,
    this.defaultCategory,
    this.isDropdownEnabled = true,
  }) : super(key: key);

  @override
  State<FormItemSampahScreen> createState() => _FormItemSampahScreenState();
}

class _FormItemSampahScreenState extends State<FormItemSampahScreen> {
  final TextEditingController _namaItemController = TextEditingController();
  final TextEditingController _subKategoriController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  String? _selectedKategori;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  
  List<String> _filteredSubCategories = [];
  bool _isSubCategoryListVisible = false;
  bool _isSearching = false;
  String _searchQuery = '';
  final _formKey = GlobalKey<FormState>();
  final FocusNode _subCategoryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Set default category if provided
    if (widget.defaultCategory != null) {
      _selectedKategori = widget.defaultCategory;
      _updateFilteredSubCategories();
    }
    
    _subCategoryFocusNode.addListener(() {
      if (_subCategoryFocusNode.hasFocus) {
        setState(() {
          _isSubCategoryListVisible = true;
        });
      }
    });
    
    _subKategoriController.addListener(() {
      setState(() {
        _searchQuery = _subKategoriController.text.toLowerCase();
        _isSearching = _searchQuery.isNotEmpty;
        _updateFilteredSubCategories();
      });
    });
  }

  void _updateFilteredSubCategories() {
    List<String> baseList = [];
    if (_selectedKategori == 'Sampah Anorganik') {
      baseList = keringSubCategories;
    } else if (_selectedKategori == 'Sampah Organik') {
      baseList = basahSubCategories;
    }
    
    if (_isSearching) {
      _filteredSubCategories = baseList
          .where((item) => item.toLowerCase().contains(_searchQuery))
          .toList();
    } else {
      _filteredSubCategories = baseList;
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Ambil Foto dengan Kamera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 90,
      );
      
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil gambar'))
      );
    }
  }
  
  void _addNewSubCategory() {
    // Get existing subcategories based on the selected category
    List<String> existingSubCategories = [];
    if (_selectedKategori == 'Sampah Anorganik') {
      existingSubCategories = keringSubCategories;
    } else if (_selectedKategori == 'Sampah Organik') {
      existingSubCategories = basahSubCategories;
    }
    
    // Show the subcategory form dialog
    showFormSubKategoriSampah(
      context: context,
      initialCategory: _selectedKategori,
      isDropdownEnabled: widget.isDropdownEnabled,
      existingSubCategories: existingSubCategories,
      onSubmit: (String subCategory, String category) {
        setState(() {
          // Add the new subcategory to the appropriate list
          if (category == 'Sampah Anorganik') {
            if (!keringSubCategories.contains(subCategory)) {
              keringSubCategories.add(subCategory);
            }
          } else if (category == 'Sampah Organik') {
            if (!basahSubCategories.contains(subCategory)) {
              basahSubCategories.add(subCategory);
            }
          }
          
          // Update the subcategory field and refresh the list
          _subKategoriController.text = subCategory;
          
          // If category changed, update the main category as well (only in state 2)
          if (widget.isDropdownEnabled && category != _selectedKategori) {
            _selectedKategori = category;
          }
          
          _updateFilteredSubCategories();
          
          // Show success message
          _showSuccessMessage();
        });
      },
    );
  }
  
  // Method to show success message when subcategory is added
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.check_circle,
              color: Color(0xFF084BC4),
            ),
            SizedBox(width: 16),
            Text(
              'Sub kategori berhasil ditambahkan',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Color(0xFFE0E0E0)),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        elevation: 4,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create new waste item
      final newItem = WasteItem(
        name: _namaItemController.text,
        category: _selectedKategori ?? '',
        subCategory: _subKategoriController.text,
        price: double.tryParse(_hargaController.text) ?? 0,
        imagePath: _imageFile?.path,
      );
      
      // Call the callback if provided
      if (widget.onItemAdded != null) {
        widget.onItemAdded!(newItem);
      }
      
      // Return to previous screen
      Navigator.of(context).pop();
    }
  }

  // Selectable dropdown with arrow (for state 2)
  Widget _buildSelectableDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
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
              _subKategoriController.clear();
              _updateFilteredSubCategories();
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kategori sampah harus dipilih';
            }
            return null;
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // Non-selectable field (for states 0 and 1)
  Widget _buildNonSelectableField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF5F5F5), // Light gray to indicate non-editable
          ),
          child: Text(
            _selectedKategori ?? '',
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // Build the subcategory dropdown
  Widget _buildSubCategorySearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _subKategoriController,
          focusNode: _subCategoryFocusNode,
          decoration: InputDecoration(
            hintText: 'Masukkan nama sub kategori',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF084BC4)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
              _isSearching = value.isNotEmpty;
              _updateFilteredSubCategories();
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Sub kategori sampah harus diisi';
            }
            return null;
          },
        ),
        if (_isSubCategoryListVisible)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _filteredSubCategories.isEmpty
                ? Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Data sub kategori tidak ditemukan',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSubCategoryListVisible = false;
                          });
                          _addNewSubCategory();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: const [
                              Icon(Icons.add, color: Color(0xFF084BC4), size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Tambah sub kategori baru',
                                style: TextStyle(
                                  color: Color(0xFF084BC4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: _filteredSubCategories.length + 1, // +1 for add new item
                    itemBuilder: (context, index) {
                      if (index < _filteredSubCategories.length) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _subKategoriController.text = _filteredSubCategories[index];
                              _isSubCategoryListVisible = false;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              _filteredSubCategories[index],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Add new subcategory option
                        return Column(
                          children: [
                            const Divider(height: 1),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isSubCategoryListVisible = false;
                                });
                                _addNewSubCategory();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: const [
                                    Icon(Icons.add, color: Color(0xFF084BC4), size: 18),
                                    SizedBox(width: 8),
                                    Text(
                                      'Tambah sub kategori baru',
                                      style: TextStyle(
                                        color: Color(0xFF084BC4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _namaItemController.dispose();
    _subKategoriController.dispose();
    _hargaController.dispose();
    _subCategoryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Setting resizeToAvoidBottomInset to false to prevent layout shifts with keyboard
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF084BC4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.recycling, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 4),
            const Text(
              'WANIGO!',
              style: TextStyle(
                color: Color(0xFF084BC4),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // Hide subcategory list when tapping outside
          setState(() {
            _isSubCategoryListVisible = false;
          });
          // Hide keyboard
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Form Item Sampah',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pengisian form untuk tambah item sampah baru',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Image Upload Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo placeholder or selected image
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF3FD),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF084BC4), width: 1.5),
                        ),
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  _imageFile!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 48,
                                  color: Color(0xFF084BC4),
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      // Button and description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _pickImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A5AEB),
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Tambah foto',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '*Pastikan foto potrait & resolusi 102x96px',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Form Fields
                  const Text(
                    'Nama Item Sampah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _namaItemController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan item sampah',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF084BC4)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama item sampah harus diisi';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Kategori Sampah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.isDropdownEnabled 
                    ? _buildSelectableDropdown()
                    : _buildNonSelectableField(),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Sub Kategori Sampah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildSubCategorySearch(),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    'Harga item sampah per satu kilogram',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _hargaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      prefixText: 'Rp',
                      prefixStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      hintText: '0',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF084BC4)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga item sampah harus diisi';
                      }
                      return null;
                    },
                  ),
                  
                  // Add padding at the bottom to ensure everything is visible when keyboard is open
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A5AEB),
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Tambah Item Sampah',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}