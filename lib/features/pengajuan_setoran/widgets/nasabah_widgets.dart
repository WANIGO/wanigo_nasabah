import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanigo_nasabah/features/pengajuan_setoran/components/bank_sampah_card.dart';

class NasabahWidgets extends StatelessWidget {
  const NasabahWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return BankSampahCard(
            title: "Bank Sampah Kawan Surabaya",
            distance: "0.5km dari lokasimu",
            status: "Aktif",
            time: "10.00 - 22.00",
            address: "Jl. Jojoran Baru III No.30 Mojo, Kec. Gubeng, Surabaya",
            isRegistered: true,
          );
        },
      ),
    );
  }
}
