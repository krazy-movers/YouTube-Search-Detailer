import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('セクション'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              value: const Text('日本語'),
            ),
          ],
        ),
      ],
    );
  }
}
