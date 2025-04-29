import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/data/models/jadwal_nasabah_model.dart';
import '/theme.dart';

class NasabahCalendarProfileCard extends StatelessWidget {
  final JadwalNasabahModel jadwal;

  const NasabahCalendarProfileCard({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildDateBox(),
          const SizedBox(width: 12),
          Expanded(child: _buildScheduleInfo()),
        ],
      ),
    );
  }

  Widget _buildDateBox() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDateMonthRow(),
          _buildDayLabel(),
        ],
      ),
    );
  }

  Widget _buildDateMonthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${jadwal.day}', style: AppTextStyles.heading1),
        const SizedBox(width: 4),
        _buildMonthLabel(),
      ],
    );
  }

  Widget _buildMonthLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(jadwal.month, style: AppTextStyles.subtitleWhite),
    );
  }

  Widget _buildDayLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(jadwal.weekday, style: AppTextStyles.subtitleWhite),
    );
  }

  Widget _buildScheduleInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: jadwal.jadwalList.map((j) {
        return _buildScheduleItem(
          color: _hexToColor(j.color),
          title: j.title,
          date: j.date,
        );
      }).toList(),
    );
  }

  Widget _buildScheduleItem({
    required Color color,
    required String title,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 35,
            margin: const EdgeInsets.only(top: 5, right: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black87,
                    )),
                const SizedBox(height: 2),
                Text(date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
