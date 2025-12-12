import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

/// Terms of service page
/// From Issue #3 - Navigation & Routing
class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By using Sinbool, you agree to these terms.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: Spacing.xl),

            _TermsSection(
              title: '1. Acceptance of Terms',
              content:
                  'By downloading, installing, or using Sinbool, you agree to be '
                  'bound by these Terms of Service. If you do not agree to these '
                  'terms, please do not use the app.',
            ),

            _TermsSection(
              title: '2. Use of the App',
              content:
                  'Sinbool is designed for educational purposes to teach children '
                  'about Islamic stories and values. The app is intended for '
                  'children under parental supervision.\n\n'
                  'You agree to:\n'
                  '• Use the app for its intended educational purpose\n'
                  '• Supervise children using the app\n'
                  '• Not misuse or attempt to hack the app\n'
                  '• Not redistribute or copy content without permission',
            ),

            _TermsSection(
              title: '3. Content',
              content:
                  'All content in Sinbool, including stories, illustrations, '
                  'audio, and quizzes, is owned by Sinbool or its licensors. '
                  'You may not reproduce, distribute, or create derivative works '
                  'without explicit permission.\n\n'
                  'Our content is reviewed by Islamic scholars to ensure accuracy, '
                  'but we encourage users to verify religious teachings with '
                  'qualified scholars.',
            ),

            _TermsSection(
              title: '4. Subscriptions',
              content:
                  'Some content may require a subscription. Subscription terms:\n\n'
                  '• Subscriptions auto-renew unless cancelled\n'
                  '• Cancel anytime through your app store\n'
                  '• No refunds for partial subscription periods\n'
                  '• Prices may change with notice',
            ),

            _TermsSection(
              title: '5. Privacy',
              content:
                  'Your privacy is important to us. Please review our Privacy '
                  'Policy to understand how we collect and use information. '
                  'We comply with COPPA and other applicable privacy laws.',
            ),

            _TermsSection(
              title: '6. Disclaimer',
              content:
                  'The app is provided "as is" without warranties of any kind. '
                  'We are not responsible for:\n\n'
                  '• Service interruptions\n'
                  '• Data loss\n'
                  '• Any damages arising from use of the app\n\n'
                  'We strive to provide accurate Islamic content but recommend '
                  'consulting qualified scholars for religious guidance.',
            ),

            _TermsSection(
              title: '7. Changes to Terms',
              content:
                  'We may update these terms from time to time. Continued use of '
                  'the app after changes constitutes acceptance of the new terms. '
                  'We will notify users of significant changes.',
            ),

            _TermsSection(
              title: '8. Contact',
              content:
                  'For questions about these Terms of Service, contact us at:\n\n'
                  'support@sinbool.com',
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

class _TermsSection extends StatelessWidget {
  const _TermsSection({
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
