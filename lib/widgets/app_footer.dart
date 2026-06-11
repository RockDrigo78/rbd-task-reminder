import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

const String rbdAppsWebsiteUrl = 'https://www.rbdapps.com/';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  Future<void> _openRbdAppsWebsite() async {
    final websiteUri = Uri.parse(rbdAppsWebsiteUrl);
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Center(
        child: InkWell(
          onTap: _openRbdAppsWebsite,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              localizations.madeByRbdApps,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.indigo.withValues(alpha: 0.6),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
