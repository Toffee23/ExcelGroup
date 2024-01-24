import 'package:course_view/core/constants/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/snack_bar.dart';

mixin ReferralPageController on Widget {
  void onCopy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showSnackbar(
      context: context,
      title: 'Text successfully copied to clipboard',
    );
  }

  void shareToFacebook(BuildContext context, String text) {
    _shareToFacebook(context, text).then((successful) {
      if (!successful) {
        showSnackbar(
          context: context,
          title: 'Could not launch facebook',
          subtitle: 'Please check if facebook is installed.',
          type: SnackbarType.error,
        );
      }
    });
  }

  Future<bool> _shareToFacebook(BuildContext context, String text) async {
    final facebookUrl = Uri.parse('${SocialMediaLinks.facebook}$text');

    if (await canLaunchUrl(facebookUrl)) {
      return await launchUrl(facebookUrl);
    } else {
      return false;
    }
  }

  void shareToInstagram(BuildContext context, String text) {
    _shareToInstagram(context, text).then((successful) {
      if (!successful) {
        showSnackbar(
          context: context,
          title: 'Could not launch instagram',
          subtitle: 'Please check if instagram is installed.',
          type: SnackbarType.error,
        );
      }
    });
  }

  Future<bool> _shareToInstagram(BuildContext context, String text) async {
    final instagram = Uri.parse(SocialMediaLinks.instagram);
    final instagramApp = Uri.parse('${SocialMediaLinks.instagramApp}$text');
    final instagramWeb = Uri.parse('${SocialMediaLinks.instagramWeb}$text');

    if (await canLaunchUrl(instagram)) {
      return await launchUrl(instagramApp);
    } else {
      return await launchUrl(instagramWeb);
    }
  }

  void shareToSms(BuildContext context, String text) async {
    _shareToSms(context, text).then((successful) {
      if (!successful) {
        showSnackbar(
          context: context,
          title: 'Could not launch SMS',
          subtitle: 'Please check if sms app is installed.',
          type: SnackbarType.error,
        );
      }
    });
  }

  Future<bool> _shareToSms(BuildContext context, String text) async {
    final smsUri = Uri.parse(SocialMediaLinks.sms);

    if (await canLaunchUrl(smsUri)) {
      return launchUrl(smsUri);
    } else {
      return false;
    }
  }

  void share(BuildContext context, String text) {
    Share.share(text, subject: 'Sharing to Facebook');
  }
}
