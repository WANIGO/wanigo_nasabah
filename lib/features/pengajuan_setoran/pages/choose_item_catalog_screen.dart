import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/components/items_card.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/pages/controller/choose_item_controller.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/widgets/empty_items.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class ChooseItemCatalogScreen extends StatelessWidget {
  ChooseItemCatalogScreen({super.key});

  final ChooseItemController controller = Get.put(ChooseItemController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildHeader(),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: _buildItemGrid(),
                ),
              ),
            ),
            Obx(() {
              if (controller.selectedItems.isEmpty) {
                return SizedBox(); // Tombol tidak muncul
              }
              return _buildBottomNav();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form Pengajuan Setoran',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF212729),
          ),
        ),
        SizedBox(height: 8.h),
        Text.rich(
          TextSpan(
            text: 'Untuk Jadwal Setoran di ',
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xFF464B4D),
            ),
            children: [
              TextSpan(
                text: '31 Mei 2025',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        _buildCategorySelector(),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Obx(() => Row(
          children: [
            _buildCategoryButton('Sampah Kering', 0),
            _buildCategoryButton('Sampah Basah', 1),
          ],
        ));
  }

  Widget _buildCategoryButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleCategory(index),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedCategory.value == index
                    ? const Color(0xFF084BC3)
                    : const Color(0xFFDFE1E7),
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: controller.selectedCategory.value == index
                    ? const Color(0xFF084BC3)
                    : const Color(0xFF585A6E),
                fontSize: 18.sp,
                fontWeight: controller.selectedCategory.value == index
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget _buildItemGrid() {
    return Obx(() {
      List<int> itemsToShow = controller.selectedCategory.value == 0
          ? [] // Sampah Kering
          : []; // Sampah Basah

      // Add logic to fill the list depending on the selected category
      if (controller.selectedCategory.value == 0) {
        itemsToShow =
            List.generate(6, (index) => index); // Example for Sampah Kering
      } else {
        itemsToShow = List.generate(
            0, (index) => index); // Example for Sampah Basah (empty)
      }

      return itemsToShow.isEmpty
          ? EmptyItems()
          : Wrap(
              spacing: 25.w,
              runSpacing: 25.h,
              children: List.generate(
                itemsToShow.length,
                (index) => WasteItemCard(
                  title: 'Nama Item Sampah $index',
                  price: 'Rp.10.000/kg',
                  imageUrl: 'https://placehold.co/140x140',
                  isSelected: controller.selectedItems.contains(index),
                  onTap: () => controller.toggleItemSelection(index),
                ),
              ),
            );
    });
  }

  Widget _buildBottomNav() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFCACACA))),
        boxShadow: [
          BoxShadow(
            color: const Color(0x070D0D12),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total ${controller.selectedItems.length} Item Sampah Dipilih',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A5AEB),
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: Text(
              'Simpan Laporan',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
