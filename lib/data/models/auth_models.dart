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
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      profilePhotoUrl: json['profile_photo_url'],
      nasabah: json['nasabah'] != null ? NasabahModel.fromJson(json['nasabah']) : null,
    );
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

/// Model untuk status profil
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
  factory ProfileStatusModel.fromJson(Map<String, dynamic> json) {
    // Handle string & object format
    if (json is String) {
      // Handle string format seperti "started", "completed"
      return ProfileStatusModel(
        isCompleted: json == "completed",
        completionPercentage: json == "completed" ? 100 : 0,
        nextStep: json == "completed" ? '' : 'step1',
      );
    }
    
    return ProfileStatusModel(
      isCompleted: json['is_completed'] ?? false,
      completionPercentage: json['completion_percentage'] ?? 0,
      nextStep: json['next_step'] ?? '',
    );
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