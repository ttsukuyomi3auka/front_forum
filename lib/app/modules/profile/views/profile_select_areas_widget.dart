import 'package:flutter/material.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/modules/profile/controllers/profile_controller.dart';

import 'package:get/get.dart';

class ProfileSelectAreas extends StatelessWidget {
  final ProfileController controller;
  final List<AreaOfActivity> areas;

  const ProfileSelectAreas(this.controller, this.areas, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 3,
        maxWidth: MediaQuery.of(context).size.width / 3,
      ),
      child: Dialog(
        backgroundColor: Colors.orange[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Выберите сферы',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    final area = areas[index];
                    return ListTile(
                      title: Text(area.title),
                      onTap: () {
                        controller.toggleSelectedArea(area.id);
                      },
                      trailing: Obx(() => Icon(
                            controller.selectedAreas.contains(area.id)
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: controller.selectedAreas.contains(area.id)
                                ? Colors.green
                                : Colors.grey,
                          )),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.saveAreas();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
