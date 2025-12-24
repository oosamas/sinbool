import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../domain/entities/settings_entity.dart';
import '../controllers/settings_controller.dart';

/// Language settings page
/// From Issue #3 - Navigation & Routing
class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final selectedLanguage = settingsState.settings.language;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Spacing.md),
        children: [
          // Info
          Card(
            color: AppColors.info.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.info),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Text(
                      'Change the language for the app interface. '
                      'Story content is available in all languages.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Language list
          Card(
            child: Column(
              children: SupportedLanguages.all.map((language) {
                final isSelected = selectedLanguage == language.code;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Center(
                          child: Text(
                            language.code.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      title: Text(language.name),
                      subtitle: Text(
                        language.nativeName,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.primary)
                          : null,
                      onTap: () async {
                        // Change the app locale via settings controller
                        await ref
                            .read(settingsControllerProvider.notifier)
                            .setLanguage(language.code);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Language changed to ${language.name}'),
                            ),
                          );
                        }
                      },
                    ),
                    if (language != SupportedLanguages.all.last)
                      const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
