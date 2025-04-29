import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/data/models/setoran_sampah_model.dart';
import '/theme.dart';

class SetoranSampahCard extends StatelessWidget {
  final SetoranSampahModel setoran;
  final Color backgroundColor;

  const SetoranSampahCard({
    super.key,
    required this.setoran,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildIconWithBadge(),
            const SizedBox(width: 16),
            _buildContent(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithBadge() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildMainIcon(),
        _buildBadgeIcon(),
      ],
    );
  }

  Widget _buildMainIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.brown[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.inventory_2,
        size: 40,
        color: Colors.brown,
      ),
    );
  }

  Widget _buildBadgeIcon() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.recycling,
        color: AppColors.highlight,
        size: 20,
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            setoran.title,
            style: AppTextStyles.contentBold,
          ),
          const SizedBox(height: 4),
          Text(
            setoran.description,
            style: AppTextStyles.contentNormal,
          ),
        ],
      ),
    );
  }
}
