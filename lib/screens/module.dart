import 'package:flutter/material.dart';
import 'package:wanigo_edu/screens/module_video.dart';

// Module Detail Screen - Shows information about a module with tabs
class ModuleDetailScreen extends StatefulWidget {
  final String title;
  
  const ModuleDetailScreen({
    Key? key, 
    required this.title,
  }) : super(key: key);

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and module info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.description, size: 16, color: Colors.blue[600]),
                    const SizedBox(width: 4),
                    const Text('10 konten', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.blue[600]),
                    const SizedBox(width: 4),
                    const Text('100 jam', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          
          // Checkerboard image
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 8,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(64, (index) {
                int row = index ~/ 8;
                int col = index % 8;
                return Container(
                  color: (row + col) % 2 == 0 ? Colors.white : Colors.grey[200],
                );
              }),
            ),
          ),
          
          // Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _tabController.index == 0 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Deskripsi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _tabController.index == 0 ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _tabController.animateTo(1);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _tabController.index == 1 ? Colors.blue : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        'Konten',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _tabController.index == 1 ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Description tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tentang Modul',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur '
                        'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur '
                        'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur '
                        'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      const Text(
                        'Objektif Modul',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${index + 1}. ', style: const TextStyle(fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur '
                                    'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      
                      const Text(
                        'Benefit Modul',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.check, color: Colors.green, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Lorem Ipsum Dulur Lorem Ipsum Dulur Lorem Ipsum Dulur',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                
                // Content tab
                ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      title: const Text(
                        'Judul Konten Modul Edukasi Sampah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: const Text('Konten Video  100poin'),
                      trailing: const Text(
                        '10:00',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VideoPlayerScreen(
                              title: 'Judul Video Edukasi Sampah',
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}