import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/data/repositories/auth_repository.dart';
import 'package:wanigo_nasabah/features/home/views/nasabah_home_screen.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';
import 'package:wanigo_nasabah/features/auth/controllers/auth_controller.dart';
import 'package:wanigo_nasabah/data/models/auth_models.dart';

class ProfileStepController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final AuthController _authController = Get.find<AuthController>();

  // Step 1 form variables
  final RxString jenisKelamin = ''.obs;
  final RxString usia = ''.obs;
  final RxString profesi = ''.obs;
  final TextEditingController profesiController = TextEditingController();

  // Step 2 form variables
  final RxString tahuMemilahSampah = ''.obs;
  final RxString motivasiMemilahSampah = ''.obs;
  final RxString nasabahBankSampah = ''.obs;
  final RxString kodeBankSampah = ''.obs;
  final TextEditingController kodeBankSampahController = TextEditingController();

  // Step 3 form variables
  final RxString frekuensiMemilahSampah = ''.obs;
  final RxString jenisSampahDikelola = ''.obs;

  // Loading state
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Flag untuk menunjukkan apakah controller telah di-init
  bool _isInitialized = false;
  
  // Flag untuk menunjukkan apakah controller sudah di-dispose
  bool _isDisposed = false;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print("DEBUG - ProfileStepController initialized");
    }
    
    // Sync TextEditingController with RxString
    profesiController.addListener(() {
      if (!_isDisposed && profesi.value != profesiController.text) {
        profesi.value = profesiController.text;
        if (kDebugMode) {
          print("DEBUG - profesi updated from controller: ${profesi.value}");
        }
      }
    });
    
    kodeBankSampahController.addListener(() {
      if (!_isDisposed && kodeBankSampah.value != kodeBankSampahController.text) {
        kodeBankSampah.value = kodeBankSampahController.text;
        if (kDebugMode) {
          print("DEBUG - kodeBankSampah updated from controller: ${kodeBankSampah.value}");
        }
      }
    });
    
    // Memanggil load data dengan delay untuk memastikan semua widget sudah ter-render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSavedData();
    });
    
    // Flag untuk menunjukkan controller telah di-init
    _isInitialized = true;
  }

  @override
  void onClose() {
    _isDisposed = true;
    profesiController.dispose();
    kodeBankSampahController.dispose();
    super.onClose();
  }

  /// Load any saved profile data (if returning from a later step)
  Future<void> loadSavedData() async {
    if (_isDisposed) return;
    
    try {
      if (kDebugMode) {
        print("DEBUG - Loading saved profile data");
      }
      
      // Cek user dari AuthController terlebih dahulu
      UserModel? userFromController = _authController.user.value;
      if (userFromController != null && userFromController.nasabah != null) {
        if (kDebugMode) {
          print("DEBUG - Loading profile from AuthController");
        }
        _fillProfileDataFromUser(userFromController);
        return;
      }
      
      final user = await _authRepository.getNasabahProfile();
      if (user.nasabah != null) {
        _fillProfileDataFromUser(user);
      } else if (kDebugMode) {
        print("DEBUG - User has no nasabah profile data");
      }
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error loading profile data: $e");
      }
      
      // Tambahkan default values untuk development
      if (kDebugMode) {
        print("DEBUG - Using default values for development");
        _setDefaultValuesForDevelopment();
      }
    }
  }
  
  // Metode untuk mengisi data profile dari user model
  void _fillProfileDataFromUser(UserModel user) {
    if (_isDisposed || user.nasabah == null) return;
    
    // Step 1 data
    if (user.nasabah!.jenisKelamin != null && user.nasabah!.jenisKelamin!.isNotEmpty) {
      jenisKelamin.value = user.nasabah!.jenisKelamin!;
    }
    if (user.nasabah!.usia != null && user.nasabah!.usia!.isNotEmpty) {
      usia.value = user.nasabah!.usia!;
    }
    if (user.nasabah!.profesi != null && user.nasabah!.profesi!.isNotEmpty) {
      profesi.value = user.nasabah!.profesi!;
      profesiController.text = user.nasabah!.profesi!;
    }

    // Step 2 data
    if (user.nasabah!.tahuMemilahSampah != null && user.nasabah!.tahuMemilahSampah!.isNotEmpty) {
      tahuMemilahSampah.value = user.nasabah!.tahuMemilahSampah!;
    }
    if (user.nasabah!.motivasiMemilahSampah != null && user.nasabah!.motivasiMemilahSampah!.isNotEmpty) {
      motivasiMemilahSampah.value = user.nasabah!.motivasiMemilahSampah!;
    }
    if (user.nasabah!.nasabahBankSampah != null && user.nasabah!.nasabahBankSampah!.isNotEmpty) {
      nasabahBankSampah.value = user.nasabah!.nasabahBankSampah!;
    }
    if (user.nasabah!.kodeBankSampah != null && user.nasabah!.kodeBankSampah!.isNotEmpty) {
      kodeBankSampah.value = user.nasabah!.kodeBankSampah!;
      kodeBankSampahController.text = user.nasabah!.kodeBankSampah!;
    }

    // Step 3 data
    if (user.nasabah!.frekuensiMemilahSampah != null && user.nasabah!.frekuensiMemilahSampah!.isNotEmpty) {
      frekuensiMemilahSampah.value = user.nasabah!.frekuensiMemilahSampah!;
    }
    if (user.nasabah!.jenisSampahDikelola != null && user.nasabah!.jenisSampahDikelola!.isNotEmpty) {
      jenisSampahDikelola.value = user.nasabah!.jenisSampahDikelola!;
    }
    
    if (kDebugMode) {
      print("DEBUG - Profile data loaded from user:");
      print("DEBUG - jenisKelamin: ${jenisKelamin.value}");
      print("DEBUG - usia: ${usia.value}");
      print("DEBUG - profesi: ${profesi.value}");
    }
  }
  
  // Method untuk menyediakan nilai default untuk pengembangan
  void _setDefaultValuesForDevelopment() {
    if (_isDisposed) return;
    
    // Step 1
    if (jenisKelamin.value.isEmpty) {
      jenisKelamin.value = "Laki-laki";
    }
    if (usia.value.isEmpty) {
      usia.value = "18 hingga 34 tahun";
    }
    if (profesi.value.isEmpty) {
      profesi.value = "Programmer";
      profesiController.text = "Programmer";
    }
    
    // Step 2
    if (tahuMemilahSampah.value.isEmpty) {
      tahuMemilahSampah.value = "Sudah tahu";
    }
    if (motivasiMemilahSampah.value.isEmpty) {
      motivasiMemilahSampah.value = "Menjaga lingkungan";
    }
    if (nasabahBankSampah.value.isEmpty) {
      nasabahBankSampah.value = "Tidak, belum";
    }
    
    // Step 3
    if (frekuensiMemilahSampah.value.isEmpty) {
      frekuensiMemilahSampah.value = "Setiap minggu";
    }
    if (jenisSampahDikelola.value.isEmpty) {
      jenisSampahDikelola.value = "Plastik";
    }
    
    if (kDebugMode) {
      print("DEBUG - Default values set for development");
    }
  }

  // Step 1 setters
  void setJenisKelamin(String value) {
    if (_isDisposed) return;
    
    jenisKelamin.value = value;
    if (kDebugMode) {
      print("DEBUG - jenisKelamin set to: $value");
    }
  }
  
  void setUsia(String value) {
    if (_isDisposed) return;
    
    usia.value = value;
    if (kDebugMode) {
      print("DEBUG - usia set to: $value");
    }
  }
  
  void setProfesi(String value) {
    if (_isDisposed) return;
    
    // Update both the RxString and the controller to ensure they are in sync
    profesi.value = value;
    
    // Only update controller if it's different to avoid infinite loops
    if (profesiController.text != value) {
      profesiController.text = value;
    }
    
    if (kDebugMode) {
      print("DEBUG - profesi set to: $value");
    }
  }

  // Step 2 setters
  void setTahuMemilahSampah(String value) {
    if (_isDisposed) return;
    tahuMemilahSampah.value = value;
  }
  
  void setMotivasiMemilahSampah(String value) {
    if (_isDisposed) return;
    motivasiMemilahSampah.value = value;
  }
  
  void setNasabahBankSampah(String value) {
    if (_isDisposed) return;
    
    nasabahBankSampah.value = value;
    if (value == "Tidak, belum") {
      kodeBankSampah.value = '';
      kodeBankSampahController.text = '';
    }
  }
  
  void setKodeBankSampah(String value) {
    if (_isDisposed) return;
    
    kodeBankSampah.value = value;
    
    // Only update controller if it's different to avoid infinite loops
    if (kodeBankSampahController.text != value) {
      kodeBankSampahController.text = value;
    }
  }

  // Step 3 setters
  void setFrekuensiMemilahSampah(String value) {
    if (_isDisposed) return;
    frekuensiMemilahSampah.value = value;
  }
  
  void setJenisSampahDikelola(String value) {
    if (_isDisposed) return;
    jenisSampahDikelola.value = value;
  }

  // Form validation
  bool isStep1Valid() {
    if (kDebugMode) {
      print("DEBUG - Checking step1 validity:");
      print("DEBUG - jenisKelamin: ${jenisKelamin.value}");
      print("DEBUG - usia: ${usia.value}");
      print("DEBUG - profesi: ${profesi.value}");
      print("DEBUG - profesiController.text: ${profesiController.text}");
    }
    
    // Selalu return true jika dalam development mode
    if (kDebugMode) {
      return true;
    }
    
    return jenisKelamin.value.isNotEmpty &&
           usia.value.isNotEmpty &&
           (profesi.value.isNotEmpty || profesiController.text.isNotEmpty);
  }

  bool isStep2Valid() {
    // Selalu return true jika dalam development mode
    if (kDebugMode) {
      return true;
    }
    
    if (tahuMemilahSampah.value.isEmpty ||
        motivasiMemilahSampah.value.isEmpty ||
        nasabahBankSampah.value.isEmpty) {
      return false;
    }
    if (nasabahBankSampah.value == "Iya, sudah" &&
        kodeBankSampah.value.isEmpty) {
      return false;
    }
    return true;
  }

  bool isStep3Valid() {
    // Selalu return true jika dalam development mode
    if (kDebugMode) {
      return true;
    }
    
    return frekuensiMemilahSampah.value.isNotEmpty &&
           jenisSampahDikelola.value.isNotEmpty;
  }

  // Save data and navigate to next step
  Future<void> saveStep1AndNext() async {
    if (_isDisposed) return;
    
    if (kDebugMode) {
      print("DEBUG - saveStep1AndNext() called");
    }
    
    // Ensure profesi is set from controller
    if (profesiController.text.isNotEmpty && profesi.value.isEmpty) {
      profesi.value = profesiController.text;
    }
    
    // Skip validasi jika dalam mode development
    if (kDebugMode && !isStep1Valid()) {
      if (kDebugMode) {
        print("DEBUG - Bypassing validation in development mode");
      }
      
      // Isi dengan nilai default jika kosong
      if (jenisKelamin.value.isEmpty) {
        jenisKelamin.value = "Laki-laki";
      }
      if (usia.value.isEmpty) {
        usia.value = "18 hingga 34 tahun";
      }
      if (profesi.value.isEmpty) {
        profesi.value = "Programmer";
        profesiController.text = "Programmer";
      }
    }
    
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (kDebugMode) {
        print("DEBUG - Attempting to save profile step 1");
        print("DEBUG - jenisKelamin: ${jenisKelamin.value}");
        print("DEBUG - usia: ${usia.value}");
        print("DEBUG - profesi: ${profesi.value}");
      }
      
      // Call API to update profile step 1
      final response = await _authRepository.updateProfileStep1(
        jenisKelamin: jenisKelamin.value,
        usia: usia.value,
        profesi: profesi.value,
      );

      if (response['status'] == 'success') {
        // Refresh AuthController data
        await _authController.refreshUserProfile();
        Get.toNamed(Routes.profileStep2);
      } else {
        errorMessage.value = response['message'] ?? 'Gagal menyimpan data. Silakan coba lagi.';
        
        // Exception untuk development
        if (kDebugMode) {
          print("DEBUG - Error in saveStep1AndNext: ${errorMessage.value}");
          print("DEBUG - Bypassing error in development mode");
          Get.toNamed(Routes.profileStep2);
          return;
        }
        
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      if (kDebugMode) {
        print("DEBUG - Error saving step 1: $e");
        
        // Exception untuk development
        print("DEBUG - Bypassing error in development mode");
        Get.toNamed(Routes.profileStep2);
        return;
      }
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }

  Future<void> saveStep2AndNext() async {
    if (_isDisposed) return;
    
    if (kDebugMode) {
      print("DEBUG - saveStep2AndNext() called");
    }
    
    // Skip validasi jika dalam mode development
    if (kDebugMode && !isStep2Valid()) {
      if (kDebugMode) {
        print("DEBUG - Bypassing validation in development mode");
      }
      
      // Isi dengan nilai default jika kosong
      if (tahuMemilahSampah.value.isEmpty) {
        tahuMemilahSampah.value = "Sudah tahu";
      }
      if (motivasiMemilahSampah.value.isEmpty) {
        motivasiMemilahSampah.value = "Menjaga lingkungan";
      }
      if (nasabahBankSampah.value.isEmpty) {
        nasabahBankSampah.value = "Tidak, belum";
      }
    }
    
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (kDebugMode) {
        print("DEBUG - Attempting to save profile step 2");
      }
      
      // Call API to update profile step 2
      final response = await _authRepository.updateProfileStep2(
        tahuMemilahSampah: tahuMemilahSampah.value,
        motivasiMemilahSampah: motivasiMemilahSampah.value,
        nasabahBankSampah: nasabahBankSampah.value,
        kodeBankSampah: nasabahBankSampah.value == "Iya, sudah" ? kodeBankSampah.value : null,
      );

      if (response['status'] == 'success') {
        // Refresh AuthController data
        await _authController.refreshUserProfile();
        Get.toNamed(Routes.profileStep3);
      } else {
        errorMessage.value = response['message'] ?? 'Gagal menyimpan data. Silakan coba lagi.';
        
        // Exception untuk development
        if (kDebugMode) {
          print("DEBUG - Error in saveStep2AndNext: ${errorMessage.value}");
          print("DEBUG - Bypassing error in development mode");
          Get.toNamed(Routes.profileStep3);
          return;
        }
        
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      if (kDebugMode) {
        print("DEBUG - Error saving step 2: $e");
        
        // Exception untuk development
        print("DEBUG - Bypassing error in development mode");
        Get.toNamed(Routes.profileStep3);
        return;
      }
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }

  Future<void> saveStep3AndFinish() async {
    if (_isDisposed) return;
    
    if (kDebugMode) {
      print("DEBUG - saveStep3AndFinish() called");
    }
    
    // Skip validasi jika dalam mode development
    if (kDebugMode && !isStep3Valid()) {
      if (kDebugMode) {
        print("DEBUG - Bypassing validation in development mode");
      }
      
      // Isi dengan nilai default jika kosong
      if (frekuensiMemilahSampah.value.isEmpty) {
        frekuensiMemilahSampah.value = "Setiap minggu";
      }
      if (jenisSampahDikelola.value.isEmpty) {
        jenisSampahDikelola.value = "Plastik";
      }
    }
    
    isLoading.value = true;
    errorMessage.value = '';

    try {
      if (kDebugMode) {
        print("DEBUG - Attempting to save profile step 3");
      }
      
      // Call API to update profile step 3
      final response = await _authRepository.updateProfileStep3(
        frekuensiMemilahSampah: frekuensiMemilahSampah.value,
        jenisSampahDikelola: jenisSampahDikelola.value,
      );

      if (response['status'] == 'success') {
        // This API call completes the profile, refresh data in AuthController
        await _authController.refreshUserProfile();
        Get.offAllNamed(Routes.profileCompletion);
      } else {
        errorMessage.value = response['message'] ?? 'Gagal menyimpan data. Silakan coba lagi.';
        
        // Exception untuk development
        if (kDebugMode) {
          print("DEBUG - Error in saveStep3AndFinish: ${errorMessage.value}");
          print("DEBUG - Bypassing error in development mode");
          Get.offAllNamed(Routes.profileCompletion);
          return;
        }
        
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      if (kDebugMode) {
        print("DEBUG - Error saving step 3: $e");
        
        // Exception untuk development
        print("DEBUG - Bypassing error in development mode");
        Get.offAllNamed(Routes.profileCompletion);
        return;
      }
      
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (!_isDisposed) {
        isLoading.value = false;
      }
    }
  }

  // PERBAIKAN: Metode untuk navigasi ke home
  void goToHomeScreen() {
    if (_isDisposed) return;
    
    if (kDebugMode) {
      print("DEBUG - goToHomeScreen() called directly");
    }
    
    try {
      // Coba langsung menggunakan offAllNamed untuk membersihkan stack navigasi
      Get.offAllNamed(Routes.home);
    } catch (e) {
      if (kDebugMode) {
        print("DEBUG - Error in direct navigation to home: $e");
      }
      
      // Fallback navigation method jika metode utama gagal
      try {
        // Coba gunakan toNamed jika offAllNamed gagal
        Get.toNamed(Routes.home);
      } catch (e2) {
        if (kDebugMode) {
          print("DEBUG - Error in fallback navigation to home: $e2");
        }
        
        // Fallback terakhir: gunakan Get.to
        Get.to(() => const NasabahHomeScreen()); // Pastikan HomePage sudah diimpor
      }
    }
  }
}