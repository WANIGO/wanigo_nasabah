import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanigo_nasabah/data/models/auth_models.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

class AuthController extends GetxController {
  // Repository untuk autentikasi
  final AuthRepository _authRepository = AuthRepository();
  
  // State variables
  final RxBool isLoggedIn = false.obs;
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final Rx<ProfileStatusModel?> profileStatus = Rx<ProfileStatusModel?>(null);
  
  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("DEBUG - AuthController initialized");
    }
    checkInitialRoute();
  }
  
  /// Memeriksa rute awal aplikasi (splash -> onboarding -> login)
  Future<void> checkInitialRoute() async {
    try {
      if (kDebugMode) {
        print("DEBUG - Checking initial route");
      }
      
      // Cek apakah pengguna sudah melihat onboarding
      final prefs = await SharedPreferences.getInstance();
      final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
      
      if (!hasSeenOnboarding) {
        // Pengguna belum melihat onboarding, arahkan ke onboarding
        if (kDebugMode) {
          print("DEBUG - User has not seen onboarding, navigating to onboarding");
        }
        Get.offAllNamed(Routes.onboarding);
        return;
      }
      
      // Pengguna sudah melihat onboarding, cek status login
      if (kDebugMode) {
        print("DEBUG - User has seen onboarding, checking login status");
      }
      checkLoginStatus();
    } catch (e) {
      // Error handling
      if (kDebugMode) {
        print("DEBUG - Error checking initial route: $e");
      }
      // Default fallback ke login
      Get.offAllNamed(Routes.login);
    }
  }
  
  /// Memeriksa status login user
  Future<void> checkLoginStatus() async {
    try {
      // Cek token
      final token = await _authRepository.getToken();
      
      if (token != null && token.isNotEmpty) {
        // Pengguna sudah login
        if (kDebugMode) {
          print("DEBUG - User has valid token");
        }
        
        // Ambil data user dari storage
        final savedUser = await _authRepository.getUser();
        final savedStatus = await _authRepository.getProfileStatus();
        
        if (savedUser != null) {
          // Set status login dan data user
          user.value = savedUser;
          profileStatus.value = savedStatus;
          isLoggedIn.value = true;
          
          // Cek profile status dan navigasi ke halaman yang sesuai
          await navigateBasedOnProfileStatus();
        } else {
          // Token ada tapi user tidak ada, coba refresh dari API
          try {
            final refreshedUser = await _authRepository.getNasabahProfile();
            final newStatus = await checkProfileStatus();
            
            user.value = refreshedUser;
            profileStatus.value = newStatus;
            isLoggedIn.value = true;
            
            // Navigate berdasarkan status
            await navigateBasedOnProfileStatus();
          } catch (e) {
            // Jika API gagal, reset login state
            if (kDebugMode) {
              print("DEBUG - Failed to refresh user data: $e");
              
              // PERBAIKAN 1: Development bypass untuk error koneksi
              print("DEBUG - Development mode - bypassing error connection");
              
              // Set nilai default untuk development
              _setDefaultDevelopmentUser();
              isLoggedIn.value = true;
              
              // Navigate berdasarkan nilai default
              await navigateBasedOnProfileStatus();
              return;
            }
            await logout(redirect: true);
          }
        }
      } else {
        // Tidak ada token, status tidak login
        if (kDebugMode) {
          print("DEBUG - No valid token, user is not logged in");
        }
        isLoggedIn.value = false;
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      // Error handling
      if (kDebugMode) {
        print("DEBUG - Error checking login status: $e");
        
        // PERBAIKAN 2: Development bypass untuk error
        if (kDebugMode) {
          print("DEBUG - Development mode - bypassing error");
          isLoggedIn.value = false;
          Get.offAllNamed(Routes.login);
          return;
        }
      }
      isLoggedIn.value = false;
      Get.offAllNamed(Routes.login);
    }
  }
  
  /// Memeriksa status profil dari API dan mengupdate informasi lokal
  Future<ProfileStatusModel> checkProfileStatus() async {
    try {
      if (kDebugMode) {
        print("DEBUG - Checking profile status from API");
      }
      
      final ProfileStatusModel newStatus = await _authRepository.checkProfileStatus();
      
      // Update profileStatus
      profileStatus.value = newStatus;
      
      if (kDebugMode) {
        print("DEBUG - Profile status updated: isCompleted=${newStatus.isCompleted}, nextStep=${newStatus.nextStep}");
      }
      
      return newStatus;
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error checking profile status: $e");
        
        // PERBAIKAN 3: Development bypass untuk error
        if (kDebugMode) {
          print("DEBUG - Development mode - using default profile status");
          
          // Gunakan default profile status untuk development
          final defaultStatus = ProfileStatusModel(
            isCompleted: false,
            completionPercentage: 0,
            nextStep: 'step1',
          );
          
          profileStatus.value = defaultStatus;
          return defaultStatus;
        }
      }
      
      // Return saved profile status or default
      final savedStatus = await _authRepository.getProfileStatus();
      if (savedStatus != null) {
        // Update profileStatus with saved value
        profileStatus.value = savedStatus;
        return savedStatus;
      }
      
      // Return default if nothing available
      final defaultStatus = ProfileStatusModel(
        isCompleted: false,
        completionPercentage: 0,
        nextStep: 'step1',
      );
      
      profileStatus.value = defaultStatus;
      return defaultStatus;
    }
  }
  
  /// Menandai bahwa pengguna sudah melihat onboarding
  Future<void> setOnboardingComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);
      if (kDebugMode) {
        print("DEBUG - Onboarding marked as complete");
      }
      // Setelah onboarding, arahkan ke login
      Get.offAllNamed(Routes.login);
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error setting onboarding flag: $e");
      }
      // Fallback
      Get.offAllNamed(Routes.login);
    }
  }
  
  /// Logout dari aplikasi
  Future<void> logout({bool redirect = true}) async {
    try {
      // Call API logout
      await _authRepository.logout();
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error during logout: $e");
      }
    } finally {
      // Reset state
      isLoggedIn.value = false;
      user.value = null;
      profileStatus.value = null;
      
      // Redirect ke login
      if (redirect) {
        Get.offAllNamed(Routes.login);
      }
    }
  }
  
  /// Navigasi berdasarkan status profil
  Future<void> navigateBasedOnProfileStatus() async {
    if (!isLoggedIn.value) {
      // Jika belum login, arahkan ke login
      if (kDebugMode) {
        print("DEBUG - Not logged in, navigating to login");
      }
      Get.offAllNamed(Routes.login);
      return;
    }
    
    // Jika tidak ada data profile status, coba refresh dari API
    if (profileStatus.value == null) {
      try {
        if (kDebugMode) {
          print("DEBUG - Profile status is null, fetching from API");
        }
        final newStatus = await checkProfileStatus();
        profileStatus.value = newStatus;
      } catch (e) {
        if (kDebugMode) {
          print("DEBUG - Failed to get profile status: $e");
          
          // PERBAIKAN 4: Development bypass untuk error
          if (kDebugMode) {
            print("DEBUG - Development mode - using default profile status");
            profileStatus.value = ProfileStatusModel(
              isCompleted: false,
              completionPercentage: 0,
              nextStep: 'step1',
            );
          } else {
            // Jika gagal, arahkan ke login
            Get.offAllNamed(Routes.login);
            return;
          }
        } else {
          // Jika gagal, arahkan ke login
          Get.offAllNamed(Routes.login);
          return;
        }
      }
    }
    
    // PERBAIKAN 5: Cek field jenis_sampah_dikelola terlebih dahulu sebagai indikator profil lengkap
    if (user.value?.nasabah != null && 
        user.value!.nasabah!.jenisSampahDikelola != null && 
        user.value!.nasabah!.jenisSampahDikelola!.isNotEmpty) {
      
      if (kDebugMode) {
        print("DEBUG - Profile complete based on jenis_sampah_dikelola, redirecting to home");
      }
      Get.offAllNamed(Routes.home);
      return;
    }
    
    // Navigasi berdasarkan status profil dari API
    if (profileStatus.value!.isCompleted) {
      // Profil sudah lengkap, arahkan ke home
      if (kDebugMode) {
        print("DEBUG - Profile is complete, navigating to home");
      }
      Get.offAllNamed(Routes.home);
    } else {
      // Profil belum lengkap
      if (profileStatus.value!.nextStep.isEmpty) {
        if (kDebugMode) {
          print("DEBUG - Profile incomplete but nextStep is empty, navigating to insight");
        }
        Get.offAllNamed(Routes.insight, arguments: user.value?.name ?? "");
      } else {
        // Arahkan ke step yang sesuai
        switch (profileStatus.value!.nextStep) {
          case 'step1':
            if (kDebugMode) {
              print("DEBUG - Navigating to profile step 1");
            }
            Get.offAllNamed(Routes.profileStep1);
            break;
          case 'step2':
            if (kDebugMode) {
              print("DEBUG - Navigating to profile step 2");
            }
            Get.offAllNamed(Routes.profileStep2);
            break;
          case 'step3':
            if (kDebugMode) {
              print("DEBUG - Navigating to profile step 3");
            }
            Get.offAllNamed(Routes.profileStep3);
            break;
          default:
            if (kDebugMode) {
              print("DEBUG - Unknown profile step: ${profileStatus.value!.nextStep}, navigating to insight");
            }
            Get.offAllNamed(Routes.insight, arguments: user.value?.name ?? "");
        }
      }
    }
  }
  
  /// Refresh data profil pengguna dari API
  Future<void> refreshUserProfile() async {
    try {
      if (!isLoggedIn.value) {
        if (kDebugMode) {
          print("DEBUG - Not logged in, cannot refresh profile");
        }
        return;
      }
      
      if (kDebugMode) {
        print("DEBUG - Refreshing user profile from API");
      }
      
      // Ambil data user dan profile status dari API
      final refreshedUser = await _authRepository.getNasabahProfile();
      final refreshedStatus = await checkProfileStatus();
      
      // Update state
      user.value = refreshedUser;
      profileStatus.value = refreshedStatus;
      
      if (kDebugMode) {
        print("DEBUG - User profile refreshed successfully");
        if (refreshedUser.nasabah != null) {
          print("DEBUG - Refreshed jenis_sampah_dikelola: ${refreshedUser.nasabah!.jenisSampahDikelola}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error refreshing user profile: $e");
        
        // PERBAIKAN 6: Development bypass untuk error
        if (kDebugMode) {
          print("DEBUG - Development mode - setting default user for refresh");
          _setDefaultDevelopmentUser();
        }
      }
    }
  }
  
  // PERBAIKAN 7: Method untuk mengatur nilai default untuk mode development
  void _setDefaultDevelopmentUser() {
    if (!kDebugMode) return;
    
    // Buat model nasabah default
    final defaultNasabah = NasabahModel(
      id: 1,
      userId: 1,
      jenisKelamin: 'Laki-laki',
      usia: '18 hingga 34 tahun',
      profesi: 'Developer',
      tahuMemilahSampah: 'Sudah tahu',
      motivasiMemilahSampah: 'Menjaga lingkungan',
      nasabahBankSampah: 'Tidak, belum',
      kodeBankSampah: null,
      frekuensiMemilahSampah: 'Setiap minggu',
      jenisSampahDikelola: 'Plastik',
      profileCompletedAt: '2025-04-25T10:30:00.000000Z',
      createdAt: '2025-04-25T10:15:00.000000Z',
      updatedAt: '2025-04-25T10:30:00.000000Z',
    );
    
    // Buat user model default
    user.value = UserModel(
      id: 1,
      name: 'User Test',
      email: 'test@example.com',
      phoneNumber: '08123456789',
      role: 'nasabah',
      createdAt: '2025-04-25T10:00:00.000000Z',
      updatedAt: '2025-04-25T10:00:00.000000Z',
      nasabah: defaultNasabah,
    );
    
    // Buat profile status default
    profileStatus.value = ProfileStatusModel(
      isCompleted: true,
      completionPercentage: 100,
      nextStep: '',
    );
    
    if (kDebugMode) {
      print("DEBUG - Default development user has been set");
      print("DEBUG - User: ${user.value?.name}");
      print("DEBUG - jenis_sampah_dikelola: ${user.value?.nasabah?.jenisSampahDikelola}");
      print("DEBUG - Profile status: isCompleted=${profileStatus.value?.isCompleted}, nextStep=${profileStatus.value?.nextStep}");
    }
  }
}