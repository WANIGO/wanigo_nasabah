import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/data/models/profile_model.dart';
import '/theme.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return _buildCardContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const Divider(height: 24),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        const SizedBox(width: 12),
        _buildGreeting(),
        _buildPointsBadge(),
      ],
    );
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: Colors.yellow[100],
        width: 30,
        height: 30,
        child: const Icon(Icons.person, size: 30),
      ),
    );
  }

  Widget _buildGreeting() {
    return Expanded(
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.greeting,
          children: [
            const TextSpan(
              text: 'Hai, ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: profile.userName,
              style: AppTextStyles.greetingBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.highlight),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.settings, size: 16, color: AppColors.highlight),
          const SizedBox(width: 4),
          Text(
            '${profile.points} POIN',
            style: AppTextStyles.badge,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return InkWell(
      onTap: () {
        // Handle click
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daftar Sebagai Nasabah Bank Sampah',
              style: AppTextStyles.cardTitle,
            ),
            _buildCircleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.highlight,
          width: 1.5,
        ),
        color: Colors.transparent,
      ),
      child: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.highlight,
        size: 20,
      ),
    );
  }
}
