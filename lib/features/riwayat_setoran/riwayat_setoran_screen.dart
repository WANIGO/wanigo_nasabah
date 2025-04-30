import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanigo_nasabah/features/riwayat_setoran/_builder/empty_state.dart';
import 'package:wanigo_nasabah/features/riwayat_setoran/controller/riwayat_setoran_controller.dart';
import 'package:wanigo_ui/wanigo_ui.dart';

class RiwayatSetoranScreen extends StatelessWidget {
  RiwayatSetoranScreen({Key? key}) : super(key: key);

  final RiwayatSetoranController controller =
      Get.put(RiwayatSetoranController());

  @override
  Widget build(BuildContext context) {
    return BaseWidgetContainer(
      appBar: GlobalAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Tabs (Riwayat & Berlangsung)
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Riwayat Tab
                  Obx(() => GestureDetector(
                        onTap: () => controller.changeMainTab(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: controller.mainTabIndex.value == 0 ? 2 : 1,
                              color: controller.mainTabIndex.value == 0
                                  ? const Color(0xFF084BC3)
                                  : const Color(0xFFDFE1E7),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Riwayat',
                                textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                      )),

                  // Berlangsung Tab
                  Obx(() => GestureDetector(
                        onTap: () => controller.changeMainTab(1),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: controller.mainTabIndex.value == 1 ? 2 : 1,
                              color: controller.mainTabIndex.value == 1
                                  ? const Color(0xFF084BC3)
                                  : const Color(0xFFDFE1E7),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Berlangsung',
                                textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),

            // Sub Tabs (Selesai & Dibatalkan) - Only visible when Riwayat is selected
            Obx(() => Visibility(
                  visible: controller.mainTabIndex.value == 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 18, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Selesai Tab
                        GestureDetector(
                          onTap: () => controller.changeSubTab(0),
                          child: Container(
                            width: 170,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF6F8FA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              shadows: controller.subTabIndex.value == 0
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
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
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        // Dibatalkan Tab
                        GestureDetector(
                          onTap: () => controller.changeSubTab(1),
                          child: Container(
                            width: 170,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF6F8FA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              shadows: controller.subTabIndex.value == 1
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),

            // Content area - would be populated based on selected tabs
            Obx(() {
              // Main tab content
              if (controller.mainTabIndex.value == 0) {
                // Riwayat tab selected
                // Here you would display content based on the selected subtab
                if (controller.subTabIndex.value == 0) {
                  // Selesai subtab content
                  return _buildEmptyState("Selesai content would go here");
                } else {
                  // Dibatalkan subtab content
                  return _buildEmptyState("Dibatalkan content would go here");
                }
              } else {
                // Berlangsung tab selected
                return _buildEmptyState("Berlangsung content would go here");
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return EmptyStateWidgets();
  }
}
