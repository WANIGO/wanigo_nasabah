import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/waste_history/_builder/empty_state.dart';
import 'package:wanigo_nasabah/features/waste_history/controllers/mitra_setoran_sampah_controller.dart';
import 'package:wanigo_nasabah/widgets/global_app_bar.dart';

class MitraPembelianSampahScreen extends StatelessWidget {
  MitraPembelianSampahScreen({Key? key}) : super(key: key);

  final SetoranController controller = Get.put(SetoranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pembelian Sampah',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => GestureDetector(
                          onTap: () => controller.changeMainTab(0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.mainTabIndex.value == 0
                                      ? const Color(0xFF084BC3)
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Riwayat',
                                style: TextStyle(
                                  color: controller.mainTabIndex.value == 0
                                      ? const Color(0xFF084BC3)
                                      : const Color(0xFF585A6E),
                                  fontSize: 18,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: controller.mainTabIndex.value == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  height: 1.55,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Obx(() => GestureDetector(
                          onTap: () => controller.changeMainTab(1),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.mainTabIndex.value == 1
                                      ? const Color(0xFF084BC3)
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Berlangsung',
                                style: TextStyle(
                                  color: controller.mainTabIndex.value == 1
                                      ? const Color(0xFF084BC3)
                                      : const Color(0xFF585A6E),
                                  fontSize: 18,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: controller.mainTabIndex.value == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  height: 1.55,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: controller.mainTabIndex.value == 0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => controller.changeSubTab(0),
                            child: Container(
                              width: 170,
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F8FA),
                                borderRadius: BorderRadius.circular(6),
                                border: Border(
                                  bottom: BorderSide(
                                    color: controller.subTabIndex.value == 0
                                        ? const Color(0xFF084BC3)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                boxShadow: controller.subTabIndex.value == 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  'Selesai',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF464B4D),
                                    fontSize: 12,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight:
                                        controller.subTabIndex.value == 0
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    letterSpacing: 0.12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => controller.changeSubTab(1),
                            child: Container(
                              width: 170,
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F8FA),
                                borderRadius: BorderRadius.circular(6),
                                border: Border(
                                  bottom: BorderSide(
                                    color: controller.subTabIndex.value == 1
                                        ? const Color(0xFF084BC3)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                boxShadow: controller.subTabIndex.value == 1
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  'Dibatalkan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF464B4D),
                                    fontSize: 12,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight:
                                        controller.subTabIndex.value == 1
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    letterSpacing: 0.12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Obx(() {
                if (controller.mainTabIndex.value == 0) {
                  if (controller.subTabIndex.value == 0) {
                    return _buildEmptyState("Selesai content would go here");
                  } else {
                    return _buildEmptyState("Dibatalkan content would go here");
                  }
                } else {
                  return _buildEmptyState("Berlangsung content would go here");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return EmptyStateWidgets();
  }
}
