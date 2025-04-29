import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/data/models/calendar_schedule_model.dart';
import '/theme.dart';

class CalendarProfile extends StatelessWidget {
  final CalendarScheduleModel schedule;

  const CalendarProfile({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _buildContainerDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateBox(),
          const SizedBox(width: 12),
          _buildContentSection(),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.lightGrey),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
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
        Text('${schedule.day}', style: AppTextStyles.heading1),
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
      child: Text(schedule.month, style: AppTextStyles.subtitleWhite),
    );
  }

  Widget _buildDayLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(schedule.weekday, style: AppTextStyles.subtitleWhite),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleWithIndicator(),
          const SizedBox(height: 12),
          _buildScheduleButton(),
        ],
      ),
    );
  }

  Widget _buildTitleWithIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVerticalIndicator(),
        Expanded(
          child: Text(
            schedule.message,
            style: AppTextStyles.smallBold,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalIndicator() {
    return Container(
      width: 4,
      height: 30,
      margin: const EdgeInsets.only(top: 2, right: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildScheduleButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Navigasi ke halaman atur jadwal
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text(
          'Atur Jadwal Pemilahan',
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
