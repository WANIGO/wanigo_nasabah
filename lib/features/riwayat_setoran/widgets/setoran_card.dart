import 'package:flutter/material.dart';

class SetoranCard extends StatelessWidget {
  final String kodeSetoran;
  final String status;
  final Color statusColor;
  final Color statusBackground;
  final String namaBankSampah;
  final String nominal;
  final String detailItem;
  final String poin;
  final String tanggal;
  final VoidCallback onDetailPressed;

  const SetoranCard({
    super.key,
    required this.kodeSetoran,
    required this.status,
    required this.statusColor,
    required this.statusBackground,
    required this.namaBankSampah,
    required this.nominal,
    required this.detailItem,
    required this.poin,
    required this.tanggal,
    required this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFCACACA)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 6),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.6, color: Color(0xFFCACACA)),
              ),
            ),
            child: Row(
              children: [
                // Kode Setoran
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kode Setoran Sampah',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito Sans',
                          color: Color(0xFF212729),
                        ),
                      ),
                      Text(
                        kodeSetoran,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito Sans',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    border: Border.all(color: statusColor),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F0D0D12),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Nama Bank & Total
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.6, color: Color(0xFFCACACA)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaBankSampah,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito Sans',
                    letterSpacing: -0.54,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          nominal,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito Sans',
                            color: Color(0xFF084BC3),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          detailItem,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Nunito Sans',
                            color: Color(0xFF212729),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0EBFF),
                        border: Border.all(
                            color: const Color(0xFF073C9D), width: 0.6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        poin,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito Sans',
                          color: Color(0xFF052D75),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Tanggal dan tombol
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Terakhir pada $tanggal',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito Sans',
                  color: Color(0xFF212729),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A5AEB),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                onPressed: onDetailPressed,
                child: const Text(
                  'Detail Setoran',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
