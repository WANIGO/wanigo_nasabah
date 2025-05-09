import 'package:flutter/material.dart';

class BankSampahCard extends StatelessWidget {
  final String nama;
  final double jarak;
  final String jamBuka;
  final String jamTutup;
  final String alamat;
  final String keterangan;
  final bool sudahTerdaftar;

  const BankSampahCard({
    super.key,
    required this.nama,
    required this.jarak,
    required this.jamBuka,
    required this.jamTutup,
    required this.alamat,
    required this.keterangan,
    this.sudahTerdaftar = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width to make layout responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 360;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              nama,
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Distance and Hours row - THIS IS CAUSING THE OVERFLOW
            // Fixed by using a more responsive layout with Wrap or Column based on screen size
            isSmallScreen
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Distance
                Text(
                  "${jarak}km dari lokasimu",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                // Status and hours
                Row(
                  children: [
                    const Text(
                      "Aktif",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$jamBuka - $jamTutup",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            )
                : Wrap(
              spacing: 12,
              children: [
                // Distance
                Text(
                  "${jarak}km dari lokasimu",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),

                // Status
                const Text(
                  "Aktif",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),

                // Opening hours
                Text(
                  "$jamBuka - $jamTutup",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Address
            Text(
              alamat,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Bottom section with note and button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Note text
                Expanded(
                  child: Text(
                    keterangan,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),

                // Registration button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 10,
                      vertical: isSmallScreen ? 8 : 10
                  ),
                  child: Text(
                    sudahTerdaftar ? "Sudah Terdaftar" : "Daftar",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}