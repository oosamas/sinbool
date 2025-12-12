import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Privacy policy page
/// From Issue #3 - Navigation & Routing
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // COPPA badge
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Radius.md),
                border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: AppColors.success),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COPPA Compliant',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
                        ),
                        Text(
                          'This app is designed for children and complies with '
                          'the Children\'s Online Privacy Protection Act.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.xl),

            _PolicySection(
              title: 'Introduction',
              content:
                  'Sinbool ("we", "our", or "us") is committed to protecting the '
                  'privacy of children who use our app. This Privacy Policy '
                  'explains our practices regarding the collection, use, and '
                  'disclosure of information from users of our application.',
            ),

            _PolicySection(
              title: 'Information We Collect',
              content:
                  'We collect minimal information necessary to provide our service:\n\n'
                  '• Usage data (lessons completed, progress)\n'
                  '• Device information for crash reporting\n'
                  '• Language preferences\n\n'
                  'We do NOT collect:\n'
                  '• Personal identifying information\n'
                  '• Location data\n'
                  '• Contact information\n'
                  '• Photos or media',
            ),

            _PolicySection(
              title: 'How We Use Information',
              content:
                  'The information we collect is used solely to:\n\n'
                  '• Track learning progress within the app\n'
                  '• Improve app performance and fix bugs\n'
                  '• Provide personalized learning experiences\n\n'
                  'We never sell or share user data with third parties.',
            ),

            _PolicySection(
              title: 'Data Storage',
              content:
                  'All learning progress and preferences are stored locally on '
                  'your device. Optional cloud sync features require explicit '
                  'parental consent and use encrypted connections.',
            ),

            _PolicySection(
              title: 'Parental Controls',
              content:
                  'Parents can:\n\n'
                  '• Access all data stored by the app\n'
                  '• Delete their child\'s data at any time\n'
                  '• Control app settings via PIN protection\n'
                  '• Set time limits for app usage\n'
                  '• Contact us with any privacy concerns',
            ),

            _PolicySection(
              title: 'Third-Party Services',
              content:
                  'We use the following third-party services:\n\n'
                  '• Firebase Analytics (anonymized usage data)\n'
                  '• Firebase Crashlytics (crash reporting)\n\n'
                  'These services are configured to comply with COPPA '
                  'requirements and do not collect personal information.',
            ),

            _PolicySection(
              title: 'Contact Us',
              content:
                  'If you have any questions about this Privacy Policy or our '
                  'data practices, please contact us at:\n\n'
                  'privacy@sinbool.com',
            ),

            const SizedBox(height: Spacing.lg),
            Text(
              'Last updated: January 2024',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textHint,
                  ),
            ),
            const SizedBox(height: Spacing.xl),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}
