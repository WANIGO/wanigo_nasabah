// File: lib/data/models/auth_models.dart

/// Model untuk data user
class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final String? profilePhotoUrl;
  final NasabahModel? nasabah;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.nasabah,
  });

  /// Factory constructor untuk membuat UserModel dari json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        role: json['role'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        profilePhotoUrl: json['profile_photo_url'],
        nasabah: json['nasabah'] != null
            ? NasabahModel.fromJson(json['nasabah'])
            : null,
      );
    } catch (e) {
      print("ERROR in UserModel.fromJson: $e");
      print("JSON data: $json");
      // Return minimal valid model dengan data yang bisa diakses
      return UserModel(
        id: json['id'],
        name: json['name'] ?? 'Unknown',
        email: json['email'] ?? 'unknown@example.com',
        phoneNumber: json['phone_number'],
        role: json['role'] ?? 'nasabah',
      );
    }
  }

  /// Convert UserModel ke json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'profile_photo_url': profilePhotoUrl,
      'nasabah': nasabah?.toJson(),
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, role: $role)';
  }
}

/// Model untuk data nasabah
class NasabahModel {
  final int? id;
  final int? userId;
  final String? jenisKelamin;
  final String? usia;
  final String? profesi;
  final String? tahuMemilahSampah;
  final String? motivasiMemilahSampah;
  final String? nasabahBankSampah;
  final String? kodeBankSampah;
  final String? frekuensiMemilahSampah;
  final String? jenisSampahDikelola;
  final String? profileCompletedAt;
  final String? createdAt;
  final String? updatedAt;

  NasabahModel({
    this.id,
    this.userId,
    this.jenisKelamin,
    this.usia,
    this.profesi,
    this.tahuMemilahSampah,
    this.motivasiMemilahSampah,
    this.nasabahBankSampah,
    this.kodeBankSampah,
    this.frekuensiMemilahSampah,
    this.jenisSampahDikelola,
    this.profileCompletedAt,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor untuk membuat NasabahModel dari json
  factory NasabahModel.fromJson(Map<String, dynamic> json) {
    try {
      return NasabahModel(
        id: json['id'],
        userId: json['user_id'],
        jenisKelamin: json['jenis_kelamin'],
        usia: json['usia'],
        profesi: json['profesi'],
        tahuMemilahSampah: json['tahu_memilah_sampah'],
        motivasiMemilahSampah: json['motivasi_memilah_sampah'],
        nasabahBankSampah: json['nasabah_bank_sampah'],
        kodeBankSampah: json['kode_bank_sampah'],
        frekuensiMemilahSampah: json['frekuensi_memilah_sampah'],
        jenisSampahDikelola: json['jenis_sampah_dikelola'],
        profileCompletedAt: json['profile_completed_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
    } catch (e) {
      print("ERROR in NasabahModel.fromJson: $e");
      print("JSON data: $json");
      // Return model minimal yang valid
      return NasabahModel(
        id: json['id'],
        userId: json['user_id'],
      );
    }
  }

  /// Convert NasabahModel ke json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'jenis_kelamin': jenisKelamin,
      'usia': usia,
      'profesi': profesi,
      'tahu_memilah_sampah': tahuMemilahSampah,
      'motivasi_memilah_sampah': motivasiMemilahSampah,
      'nasabah_bank_sampah': nasabahBankSampah,
      'kode_bank_sampah': kodeBankSampah,
      'frekuensi_memilah_sampah': frekuensiMemilahSampah,
      'jenis_sampah_dikelola': jenisSampahDikelola,
      'profile_completed_at': profileCompletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'NasabahModel(id: $id, userId: $userId, jenisKelamin: $jenisKelamin, usia: $usia, profesi: $profesi)';
  }
}

/// Model untuk status profil - DIPERBAIKI untuk menangani string status API
class ProfileStatusModel {
  final bool isCompleted;
  final int completionPercentage;
  final String nextStep;

  ProfileStatusModel({
    required this.isCompleted,
    required this.completionPercentage,
    required this.nextStep,
  });

  /// Factory constructor untuk membuat ProfileStatusModel dari json
  factory ProfileStatusModel.fromJson(dynamic json) {
    try {
      // Handle string format dari API
      if (json is String) {
        final String status = json.toLowerCase();

        // Status lengkap dan umum
        if (status == "complete" || status == "completed") {
          return ProfileStatusModel(
            isCompleted: true,
            completionPercentage: 100,
            nextStep: '',
          );
        } 
        // Status awal
        else if (status == "incomplete" || status == "started") {
          return ProfileStatusModel(
            isCompleted: false,
            completionPercentage: 0,
            nextStep: 'step1',
          );
        } 
        // PERBAIKAN: Status step 1 selesai
        else if (status == "step1_complete") {
          return ProfileStatusModel(
            isCompleted: false,
            completionPercentage: 33,
            nextStep: 'step2',  // PENTING: Mengarah ke langkah berikutnya
          );
        } 
        // PERBAIKAN: Status step 2 selesai
        else if (status == "step2_complete") {
          return ProfileStatusModel(
            isCompleted: false,
            completionPercentage: 66,
            nextStep: 'step3',  // PENTING: Mengarah ke langkah berikutnya
          );
        } 
        // PERBAIKAN: Status step 3 selesai
        else if (status == "step3_complete") {
          return ProfileStatusModel(
            isCompleted: true,
            completionPercentage: 100,
            nextStep: '',
          );
        } 
        // Default untuk string yang tidak dikenal
        else {
          print("WARNING: Unknown profile status string: $status");
          return ProfileStatusModel(
            isCompleted: false,
            completionPercentage: 0,
            nextStep: 'step1',
          );
        }
      }

      // Jika json bukan string, coba proses sebagai Map
      if (json is! Map<String, dynamic>) {
        print("WARNING: ProfileStatusModel received non-map, non-string value: $json");
        return ProfileStatusModel(
          isCompleted: false,
          completionPercentage: 0,
          nextStep: 'step1',
        );
      }

      // Handle data yang mungkin null atau tidak sesuai
      bool isCompleted = false;
      int completionPercentage = 0;
      String nextStep = '';

      // Cek dan konversi ke boolean
      if (json.containsKey('is_completed')) {
        if (json['is_completed'] is bool) {
          isCompleted = json['is_completed'];
        } else if (json['is_completed'] is String) {
          isCompleted = json['is_completed'].toLowerCase() == 'true';
        } else if (json['is_completed'] is num) {
          isCompleted = json['is_completed'] > 0;
        }
      }

      // Cek dan konversi ke integer
      if (json.containsKey('completion_percentage')) {
        if (json['completion_percentage'] is int) {
          completionPercentage = json['completion_percentage'];
        } else if (json['completion_percentage'] is double) {
          completionPercentage = json['completion_percentage'].toInt();
        } else if (json['completion_percentage'] is String) {
          completionPercentage =
              int.tryParse(json['completion_percentage']) ?? 0;
        }
      }

      // Cek dan konversi ke string
      if (json.containsKey('next_step')) {
        nextStep = json['next_step']?.toString() ?? '';
      }

      return ProfileStatusModel(
        isCompleted: isCompleted,
        completionPercentage: completionPercentage,
        nextStep: nextStep,
      );
    } catch (e) {
      print("ERROR in ProfileStatusModel.fromJson: $e");
      print("JSON data: $json");

      // Return default model yang valid dalam kasus error
      return ProfileStatusModel(
        isCompleted: false,
        completionPercentage: 0,
        nextStep: 'step1',
      );
    }
  }

  /// Convert ProfileStatusModel ke json
  Map<String, dynamic> toJson() {
    return {
      'is_completed': isCompleted,
      'completion_percentage': completionPercentage,
      'next_step': nextStep,
    };
  }

  @override
  String toString() {
    return 'ProfileStatusModel(isCompleted: $isCompleted, completionPercentage: $completionPercentage, nextStep: $nextStep)';
  }
}

/// Model untuk response login
class LoginResponse {
  final UserModel user;
  final String token;
  final String tokenType;
  final ProfileStatusModel profileStatus;

  LoginResponse({
    required this.user,
    required this.token,
    required this.tokenType,
    required this.profileStatus,
  });
}

/// Model untuk response register
class RegisterResponse {
  final UserModel user;
  final String token;
  final String tokenType;
  final ProfileStatusModel profileStatus;

  RegisterResponse({
    required this.user,
    required this.token,
    required this.tokenType,
    required this.profileStatus,
  });
}