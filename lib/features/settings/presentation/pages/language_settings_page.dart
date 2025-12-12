import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Language settings page
/// From Issue #3 - Navigation & Routing
class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String _selectedLanguage = 'en';

  final List<_LanguageOption> _languages = [
    _LanguageOption(code: 'en', name: 'English', nativeName: 'English'),
    _LanguageOption(code: 'ar', name: 'Arabic', nativeName: 'العربية'),
    _LanguageOption(code: 'ur', name: 'Urdu', nativeName: 'اردو'),
    _LanguageOption(code: 'id', name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
    _LanguageOption(code: 'es', name: 'Spanish', nativeName: 'Español'),
    _LanguageOption(code: 'fr', name: 'French', nativeName: 'Français'),
  ];

  @override
  Widget build(BuildContext context) {
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
              children: _languages.map((language) {
                final isSelected = _selectedLanguage == language.code;
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
                          borderRadius: BorderRadius.circular(Radius.md),
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
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _selectedLanguage = language.code);
                        // TODO: Actually change the app locale
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Language changed to ${language.name}'),
                          ),
                        );
                      },
                    ),
                    if (language != _languages.last) const Divider(height: 1),
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

class _LanguageOption {
  const _LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  final String code;
  final String name;
  final String nativeName;
}
