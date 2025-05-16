import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/waste_history/widgets/item_sampah.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class MitraDaftarItemScreen extends StatefulWidget {
  const MitraDaftarItemScreen({super.key});

  @override
  State<MitraDaftarItemScreen> createState() => _MitraDaftarItemScreenState();
}

class _MitraDaftarItemScreenState extends State<MitraDaftarItemScreen> {
  bool isEditing = false;

  List<String> dummyItems = List.generate(3, (index) => 'Nama Item Sampah');

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void deleteItem(int index) {
    setState(() {
      dummyItems.removeAt(index);
    });
  }

  void deleteAll() {
    setState(() {
      dummyItems.clear();
    });
  }

  void addItem() {
    setState(() {
      dummyItems.add('Item Baru ${dummyItems.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalText(
              text: "Daftar Item Sampah",
              variant: TextVariant.h3,
            ),
            SizedBox(height: 8.h),
            const GlobalText(
              text: 'Untuk Jadwal Pemilahan di 31 Mei 2025',
              variant: TextVariant.smallMedium,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: toggleEditMode,
                  child: GlobalText(
                    text: isEditing ? 'Selesai' : 'Edit Daftar Item Sampah',
                    variant: TextVariant.smallBold,
                    color: Colors.blue,
                  ),
                ),
                if (isEditing)
                  GestureDetector(
                    onTap: deleteAll,
                    child: const GlobalText(
                      text: 'Hapus semua',
                      variant: TextVariant.smallBold,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: dummyItems.length,
                itemBuilder: (context, index) {
                  return ItemSampahCard(
                    title: dummyItems[index],
                    pricePerKg: 'Rp.10.000/kg',
                    showDeleteButton: isEditing,
                    onDelete: () => deleteItem(index),
                  );
                },
              ),
            ),
            if (isEditing) ...[
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: addItem,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.blue),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Tambah Item Baru',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              GlobalText(
                text: 'Total ${dummyItems.length} Item Sampah Dipilih',
                variant: TextVariant.smallMedium,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  toggleEditMode();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
