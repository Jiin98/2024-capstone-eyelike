import 'package:eye_like/controllers/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volume_key_board/volume_key_board.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsController settingsController = Get.put(SettingsController());

    @override
  void initState() { //이 코드를 글씨크기 조절이 필요한 페이지에 넣으면됨
    super.initState();
    VolumeKeyBoard.instance.addListener(_volumeKeyListener);
  }

  @override
  void dispose() {
    VolumeKeyBoard.instance.removeListener();
    super.dispose();
  }

  void _volumeKeyListener(VolumeKey event) {
    if (event == VolumeKey.up) {
      _increaseFontSize();
    } else if (event == VolumeKey.down) {
      _decreaseFontSize();
    }
  }

  void _increaseFontSize() {
    double newSize = settingsController.fontSize.value + 1;
    if (newSize <= 24) { 
      settingsController.updateFontSize(newSize);
    }
  }

  void _decreaseFontSize() {
    double newSize = settingsController.fontSize.value - 1;
    if (newSize >= 20) { 
      settingsController.updateFontSize(newSize);
    }
  }

  Widget _background() {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, 10),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: Image.asset('assets/images/main_logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '고대비 모드',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Segoe UI',
                      color: settingsController.highContrastMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Obx(() => CupertinoSwitch(
                        value: settingsController.highContrastMode.value,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          settingsController.toggleHighContrastMode();
                        },
                      )),
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 36,
              thickness: 0.8,
              color: Color(0xff454545),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity, // 부모 위젯의 최대 너비를 차지
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '글자 크기',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Segoe UI',
                        color: settingsController.highContrastMode.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '가',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Segoe UI',
                            color: settingsController.highContrastMode.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: CupertinoColors.activeGreen,
                            inactiveColor: CupertinoColors.secondarySystemFill,
                            value: settingsController.fontSize.value,
                            min: 20, // 임의값
                            max: 24, // 임의값
                            onChanged: (value) {
                              settingsController.updateFontSize(value);
                            },
                          ),
                        ),
                        Text(
                          '가',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Segoe UI',
                            color: settingsController.highContrastMode.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 36,
              thickness: 0.8,
              color: Color(0xff454545),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Obx(
          () => AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            backgroundColor: settingsController.highContrastMode.value
                ? Colors.black
                : Colors.grey[300],
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: Obx(
        () => Container(
          color: settingsController.highContrastMode.value
              ? Colors.black
              : Colors.grey[300],
          child: _background(),
        ),
      ),
    );
  }
}
