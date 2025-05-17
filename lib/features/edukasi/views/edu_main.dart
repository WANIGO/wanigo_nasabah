import 'package:flutter/material.dart';
import 'package:wanigo_nasabah/features/edukasi/views/module.dart';

class EducationModulesScreen extends StatelessWidget {
  const EducationModulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: null,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/WANIGO_logo.png',
                  width: 24,
                  height: 24,
                  color: Color(0xFF1E88E5),
                ),
                Text(
                  "WANIGO!",
                  style: TextStyle(
                    color: Color(0xFF1E88E5),
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Blue header section
          Container(
            width: double.infinity,
            color: Colors.blue[600],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Circle with waste icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          width: 24,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 16,
                        child: Container(
                          width: 20,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edukasi Sampah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Pelajari cara mengolah sampah dengan mudah, dapatkan manfaat ekonomis, sekaligus bantu jaga bumi kita',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Module list section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Modul Edukasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '1/6 terselesaikan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Module cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildModuleCard(context, isCompleted: true),
                _buildModuleCard(context, isCompleted: false, progress: 80),
                _buildModuleCard(context, isCompleted: false, progress: 80),
                _buildModuleCard(context, isCompleted: false, progress: 80),
                _buildModuleCard(context, isCompleted: false, progress: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, {required bool isCompleted, int progress = 0}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ModuleDetailScreen(
              title: 'Judul Modul Edukasi Sampah',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Checkerboard icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(9, (index) {
                    return Container(
                      color: (index % 2 == 0) ? Colors.black : Colors.white,
                    );
                  }),
                ),
              ),
              const SizedBox(width: 16),
              // Module info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Judul Modul Edukasi Sampah',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.description, size: 14, color: Colors.blue[600]),
                        const SizedBox(width: 4),
                        const Text('10 konten', style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 16),
                        Icon(Icons.access_time, size: 14, color: Colors.blue[600]),
                        const SizedBox(width: 4),
                        const Text('100 jam', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              // Status indicator
              isCompleted
                  ? Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'selesai',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        children: [
                          CircularProgressIndicator(
                            value: progress / 100,
                            strokeWidth: 5,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                          ),
                          Center(
                            child: Text(
                              '$progress%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}