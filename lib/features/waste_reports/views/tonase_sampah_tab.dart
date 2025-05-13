import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/routes/app_routes.dart';

class TonaseSampahTab extends StatefulWidget {
  const TonaseSampahTab({super.key});

  @override
  State<TonaseSampahTab> createState() => _TonaseSampahTabState();
}

class _TonaseSampahTabState extends State<TonaseSampahTab> {
  bool isSampahKering = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildSummaryCards(),
          const SizedBox(height: 24),
          const Text(
            'Visualisasi Data Setoran',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _buildToggleButton(),
          const SizedBox(height: 24),
          _buildTonaseBarChart(),
          const SizedBox(height: 24),
          _buildTonaseLineChart(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Ikhtisar Tonase Sampah',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.laporanTonaseSampah);
          },
          child: const Text(
            'Riwayat',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }


  Widget _buildSummaryCards() {
    return Row(
      children: [
        _buildCard('Total berat setoran', '100 Kilogram'),
        const SizedBox(width: 12),
        _buildCard('Total item sampah', '8 item'),
      ],
    );
  }

  Widget _buildCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isSampahKering = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSampahKering ? Colors.blue : Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                child: Text(
                  'Sampah Kering',
                  style: TextStyle(
                    color: isSampahKering ? Colors.white : Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isSampahKering = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: !isSampahKering ? Colors.blue : Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                child: Text(
                  'Sampah Basah',
                  style: TextStyle(
                    color: !isSampahKering ? Colors.white : Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTonaseBarChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChartHeader('Tonase Sampah per Item'),
        const SizedBox(height: 12),
        _buildHorizontalBar('Kertas', 150),
        _buildHorizontalBar('Plastik', 100),
        _buildHorizontalBar('Botol', 80),
        _buildHorizontalBar('Besi', 60),
        _buildHorizontalBar('Aluminium', 40),
      ],
    );
  }

  Widget _buildHorizontalBar(String label, double value) {
    double maxBar = 150.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6)),
                ),
                Container(
                  height: 12,
                  width: (value / maxBar) *
                      MediaQuery.of(context).size.width *
                      0.5,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('${value.toInt()} kg',
              style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildTonaseLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChartHeader('Tren tonase sampah'),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      const days = [
                        'SEN',
                        'SEL',
                        'RAB',
                        'KAM',
                        'JUM',
                        'SAB',
                        'MIN'
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(days[value.toInt() % 7]),
                      );
                    },
                  ),
                ),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 4),
                    const FlSpot(1, 1),
                    const FlSpot(2, 1.15),
                    const FlSpot(3, 0.8),
                    const FlSpot(4, 2.2),
                    const FlSpot(5, 3.1),
                    const FlSpot(6, 2.5),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                ),
              ],
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(6)),
          child: const Text('Mingguan',
              style: TextStyle(fontSize: 12, color: Colors.black87)),
        )
      ],
    );
  }
}
