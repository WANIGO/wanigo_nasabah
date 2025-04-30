import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

Widget buildTimelineStep({
  required IconData icon,
  required Color iconColor, // Warna tetap sebagai parameter
  required Color circleColor, // Warna tetap sebagai parameter
  required Color borderColor, // Warna tetap sebagai parameter
  required String title,
  required String date,
  required bool
      isActive, 
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: ShapeDecoration(
          color: circleColor, // Menggunakan parameter color
          shape: CircleBorder(
            side: BorderSide(
              width: 1.8,
              color: borderColor, // Menggunakan parameter color
            ),
          ),
        ),
        child: Icon(
          icon,
          size: 24.0, // Ukuran ikon disesuaikan
          color: iconColor, // Menggunakan parameter color
        ),
      ),
      const SizedBox(height: 8.0),
      SizedBox(
        width: 78, // Lebar dipertahankan untuk alignment teks
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            // Warna teks di-hardcode karena tidak bergantung pada status aktif/tidak aktif di style ini
            color: Color(0xFF1C2122),
            fontSize: 14,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.4, // Tinggi disesuaikan
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(
        width: 78, // Lebar dipertahankan untuk alignment teks
        child: Text(
          date,
          textAlign: TextAlign.center,
          style: const TextStyle(
            // Warna teks di-hardcode
            color: Color(0xFF1C2122),
            fontSize: 12,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w500,
            height: 1.4, // Tinggi disesuaikan
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

// --- Main Detail Setoran Screen Widget ---
class DetailSetoranScreen extends StatelessWidget {
  const DetailSetoranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variabel warna dihapus, nilai digunakan langsung di bawah

    return Scaffold(
      backgroundColor: Colors.white, // Biarkan Colors.white untuk kejelasan
      // --- App Bar ---
      // appBar: GlobalAppBar(), // Jika Anda memiliki GlobalAppBar
      appBar: GlobalAppBar(), // Placeholder AppBar

      // --- Body Content ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Screen Title ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Text(
                'Detail Setoran Sampah',
                style: TextStyle(
                  color: Color(0xFF212729), // Inline color darkText
                  fontSize: 28,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                  letterSpacing: -0.8,
                ),
              ),
            ),

            // --- Informasi Umum Section ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Informasi Umum Setoran',
                style: TextStyle(
                  color: Color(0xFF212729), // Inline color darkText
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                  letterSpacing: -0.54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildInfoRow(
                    'Kode Setoran Sampah',
                    'KWNA000001',
                    const Color(0xFF464B4D), // Inline color mediumText
                    const Color(0xFF212729), // Inline color darkText
                  ),
                  const SizedBox(height: 10),
                  _buildStatusRow(
                    'Status Setoran',
                    'Diproses',
                    const Color(0xFF464B4D), // Inline color mediumText
                  ),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                    'Nama Bank Sampah',
                    'Bank Sampah Kawan Sura..',
                    const Color(0xFF464B4D), // Inline color mediumText
                    const Color(0xFF212729), // Inline color darkText
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // --- Divider ---
            Container(
                height: 8,
                color: const Color(0xFFF5F5F5)), // Inline color lightDivider

            // --- Timeline Section ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                'Timeline Status Setoran Sampah',
                style: TextStyle(
                  color: Color(0xFF212729), // Inline color darkText
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                  letterSpacing: -0.54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          const Color(0xFFCACACA)), // Inline color cardBorder
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Timeline Visual ---
                    LayoutBuilder(builder: (context, constraints) {
                      double totalWidth = constraints.maxWidth;
                      // Perhitungan lainnya tetap sama

                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Step 1: Pengajuan (Completed)
                              buildTimelineStep(
                                icon: Icons.check_circle_outline,
                                iconColor: const Color(
                                    0xFF084BC3), // Inline primaryBlue
                                circleColor: const Color(
                                    0xFFCEDEFB), // Inline mediumBlueBackground
                                borderColor: const Color(
                                    0xFF084BC3), // Inline lightBlueBorder / primaryBlue
                                title: 'Pengajuan',
                                date: '20 Mei 2025',
                                isActive: true,
                              ),

                              // Step 2: Diproses (Current/Active)
                              buildTimelineStep(
                                icon: Icons.hourglass_empty,
                                iconColor: const Color(
                                    0xFF084BC3), // Inline primaryBlue
                                circleColor: const Color(
                                    0xFFCEDEFB), // Inline mediumBlueBackground
                                borderColor: const Color(
                                    0xFF084BC3), // Inline lightBlueBorder / primaryBlue
                                title: 'Diproses',
                                date: '25 Mei 2025',
                                isActive: true,
                              ),

                              // Step 3: Selesai (Pending)
                              buildTimelineStep(
                                icon: Icons.radio_button_unchecked,
                                iconColor: const Color(
                                    0xFF848788), // Inline greyBorder
                                circleColor: const Color(
                                    0xFFF2F2F2), // Inline lightGreyBackground
                                borderColor: const Color(
                                    0xFF848788), // Inline greyBorder
                                title: 'Selesai',
                                date: '-',
                                isActive: false,
                              ),
                            ],
                          ),
                          // --- Connecting Lines ---
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 35, right: 35),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                // Base grey line spanning across
                                Container(
                                  height: 4,
                                  // lightBlueBackground for the track
                                  color: const Color(0xFFADC8F8),
                                ),
                                // Active blue line showing progress
                                Container(
                                  height: 4,
                                  width: totalWidth / 2, // Progress halfway
                                  color: const Color(
                                      0xFF084BC3), // Inline primaryBlue
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20.0),

                    // --- Catatan Status ---
                    const Text(
                      'Catatan Status Setoran:',
                      style: TextStyle(
                        color: Colors.black, // Biarkan Colors.black
                        fontSize: 16,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFF464B4D), // Inline mediumText
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.55,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                'Pengajuan setoran Anda disetujui. Serahkan sampah ke Bank Sampah sesuai jadwal pada 25 Mei 2025. Alamat Bank Sampah ada di ',
                          ),
                          TextSpan(
                            text: 'tautan ini',
                            style: const TextStyle(
                              color: Color(0xFF084BC3), // Inline primaryBlue
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Tautan Alamat Bank Sampah diklik!');
                                // TODO: Implement opening link
                              },
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // --- Divider ---
            Container(
                height: 8,
                color: const Color(0xFFF5F5F5)), // Inline lightDivider

            // --- Ringkasan Section ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Text(
                'Ringkasan Setoran Sampah',
                style: TextStyle(
                  color: Color(0xFF212729), // Inline darkText
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                  letterSpacing: -0.54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFFCACACA)), // Inline cardBorder
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Total Item Sampah', '12 item'),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Total Berat Sampah', '100kg'),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Total saldo didapatkan', 'Rp1.000.000'),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'Kamu mendapatkan',
                          style: TextStyle(
                            color: Colors.black, // Biarkan Colors.black
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.55,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '0 POIN',
                          style: TextStyle(
                            color: Color(0xFF052D75), // Inline pointColor
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.55,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // --- Lihat Rincian Item ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  print('Lihat Rincian Item diklik!');
                  // TODO: Implement navigation
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lihat rincian item setoran sampah',
                        style: TextStyle(
                          color: Colors.black, // Biarkan Colors.black
                          fontSize: 14,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.55,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 18.0,
                          color: Colors.black54), // Biarkan Colors.black54
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // --- Divider ---
            Container(
                height: 8,
                color: const Color(0xFFF5F5F5)), // Inline lightDivider

            // --- Bantuan Button ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    print('Hubungi Petugas diklik!');
                    // TODO: Implement action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0A5AEB), // Inline buttonBlue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white, // Warna teks tombol
                  ),
                  child: const Text(
                    'Perlu Bantuan? Hubungi Petugas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, // Biarkan Colors.white
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }

  // Helper widget for simple key-value info rows
  Widget _buildInfoRow(
      String label, String value, Color labelColor, Color valueColor) {
    // Warna tetap sebagai parameter di sini
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor, // Menggunakan parameter
            fontSize: 14,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.55,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor, // Menggunakan parameter
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w700,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for the status row with Chip
  Widget _buildStatusRow(String label, String status, Color labelColor) {
    // Warna untuk Chip di-inline di sini karena spesifik untuk status row ini
    const Color chipBackground =
        Color(0xFFADC8F8); // Inline lightBlueBackground
    const Color chipBorder =
        Color(0xFF084BC3); // Inline lightBlueBorder / primaryBlue
    const Color chipText = Color(0xFF084BC3); // Inline primaryBlue

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor, // Menggunakan parameter
            fontSize: 14,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.55,
          ),
        ),
        Chip(
          label: const Text(
            'Diproses', // Teks status sudah ada
            style: TextStyle(
              color: chipText, // Inline color
              fontSize: 12,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              height: 1.55,
            ),
          ),
          backgroundColor: chipBackground, // Inline color
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: chipBorder, width: 1), // Inline color
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  // Helper widget for summary rows
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black, // Biarkan Colors.black
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 1.55,
            ),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.black, // Biarkan Colors.black
            fontSize: 14,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w600,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

// --- Anda mungkin perlu menambahkan main function untuk menjalankan ini ---
// void main() {
//   runApp(const MaterialApp(
//     home: DetailSetoranScreen(),
//   ));
// }
