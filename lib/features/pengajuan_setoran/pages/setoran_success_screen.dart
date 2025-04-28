import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/core/constants/images.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class SetoranSuccessScreen extends StatelessWidget {
  const SetoranSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      appBar: const GlobalAppBar(
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.pengajuansetoranSuccess, // Sesuaikan dengan path asset kamu
                      height: 150,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Pengajuan Setoran Sampah Terkirim! 🎉',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Formulir pengajuan setoran sampah kamu berhasil dibuat dan telah diajukan ke bank sampah tujuan. Proses verifikasi akan berlangsung maksimal 2x24 jam',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            Images.bottomSuccess, // Ornamen bawah (buat asset ini juga)
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
