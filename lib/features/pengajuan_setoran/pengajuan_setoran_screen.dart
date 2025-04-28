import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/widgets/nasabah_widgets.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/widgets/non_nasabah_widgets.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class PengajuanSetoranScreen extends StatelessWidget {
  const PengajuanSetoranScreen({super.key});

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
              text: "Form Pengajuan Setoran",
              variant: TextVariant.h3,
            ),
            SizedBox(height: 8.h),
            const GlobalText(
              text: 'Untuk Jadwal Setoran di 31 Mei 2025',
              variant: TextVariant.smallMedium,
            ),
            SizedBox(height: 16.h),
            // const NasabahWidgets(),
            const NonNasabahWidgets(),
          ],
        ),
      ),
    );
  }
}
