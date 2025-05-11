import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_ui/wanigo_ui.dart' hide GlobalAppBar; // Hide GlobalAppBar dari wanigo_ui
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart'; // Import GlobalAppBar lokal

class InsightIntroScreen extends StatefulWidget {
  const InsightIntroScreen({Key? key}) : super(key: key);

  @override
  State<InsightIntroScreen> createState() => _InsightIntroScreenState();
}

class _InsightIntroScreenState extends State<InsightIntroScreen> with SingleTickerProviderStateMixin {
  late String userName;
  late AnimationController _animController;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _fadeAnimation;
  final RxBool _isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    
    // Get name from arguments
    if (Get.arguments != null && Get.arguments is String) {
      userName = Get.arguments;
    } else {
      userName = "Pengguna";
    }
    
    // Setup animations
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutQuad,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    ));
    
    _animController.forward();
  }
  
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      backgroundColor: Colors.white,
      // Menggunakan GlobalAppBar dari lokal
      appBar: const GlobalAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cloud background image with recycling icon overlay
            Stack(
              alignment: Alignment.center,
              children: [
                // Background image
                Image.asset(
                  'assets/images/bg_insight.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                
                // Recycling icon in the middle of the background
                Positioned(
                  top: 10, // Move 10px downward from center
                  child: SlideTransition(
                    position: _slideUpAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Image.asset(
                        'assets/images/trash_recycle.png',
                        width: 240,
                        height: 240,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Welcome text - positioned right after the background image
            SlideTransition(
              position: _slideUpAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
                  child: GlobalText(
                    text: 'Selamat datang di WANIGO!',
                    variant: TextVariant.h4,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Subtitle
            SlideTransition(
              position: _slideUpAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: GlobalText(
                    text: 'Sebelum mulai aksi kelola sampah, bantu kami mengenal Anda dengan mengisi WANIGO! Insight',
                    variant: TextVariant.smallRegular,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Flexible spacing
            
            // Start button
            SlideTransition(
              position: _slideUpAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Obx(() => GlobalButton(
                  text: 'Mulai Sekarang',
                  variant: ButtonVariant.large,
                  isLoading: _isLoading.value,
                  onPressed: () {
                    // Show loading indicator
                    _isLoading.value = true;
                    
                    // Simulate loading then navigate to profile step 1 instead of home
                    Future.delayed(const Duration(milliseconds: 800), () {
                      _isLoading.value = false;
                      // Navigate to profile step 1
                      Get.offAllNamed(Routes.profileStep1);
                    });
                  },
                )),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Security note - light blue background with outline
            SlideTransition(
              position: _slideUpAnimation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blue800, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: AppColors.blue800,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GlobalText(
                        text: 'WANIGO! menjamin kerahasiaan data!',
                        variant: TextVariant.smallMedium,
                        color: AppColors.blue800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom wave decoration
            Image.asset(
              'assets/images/bg_main_bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}