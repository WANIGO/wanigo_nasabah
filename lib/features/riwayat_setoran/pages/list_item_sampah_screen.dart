import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/riwayat_setoran/widgets/trash_list.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class ListItemSampahScreen extends StatelessWidget {
  const ListItemSampahScreen({super.key});

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
              text: 'Untuk Setoran Sampah KWNA000001',
              variant: TextVariant.smallMedium,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return TrashPriceCard(
                    name: 'Nama Item Sampah',
                    weightKg: 0.5,
                    totalPrice: 100000,
                    pricePerKg: 10000,
                    onTap: () {
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
