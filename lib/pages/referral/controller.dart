import 'package:course_view/core/constants/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/snack_bar.dart';

mixin ReferralPageController on Widget {
  void onCopy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showSnackbar(context, 'Text successfully copied to clipboard');
  }

  void shareToFacebook(BuildContext context, String text) async {
    final facebookUrl = Uri.parse('${SocialMediaLinks.facebook}$text');

    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl);
    } else {
      print('Could not launch $facebookUrl');
    }
  }

  void shareToInstagram(BuildContext context, String text) async {
    final instagram = Uri.parse(SocialMediaLinks.instagram);
    final instagramApp = Uri.parse('${SocialMediaLinks.instagramApp}$text');
    final instagramWeb = Uri.parse('${SocialMediaLinks.instagramWeb}$text');

    if (await canLaunchUrl(instagram)) {
      await launchUrl(instagramApp);
    } else {
      await launchUrl(instagramWeb);
    }
  }

  void shareToMessenger(BuildContext context, String text) async {
    final messenger = Uri.parse(SocialMediaLinks.messenger);
    final messengerApp = Uri.parse('${SocialMediaLinks.messengerApp}$text');
    final messengerWeb = Uri.parse('${SocialMediaLinks.messengerWeb}$text');
    if (await canLaunchUrl(messenger)) {
      await launchUrl(messengerApp);
    } else {
      await launchUrl(messengerWeb);
    }
  }

  void share(BuildContext context, String text) {
    Share.share(text, subject: 'Sharing to Facebook');
  }
}
