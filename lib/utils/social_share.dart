import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialShare {
  static Future<void> shareBusiness(
      {required String socialMedia, required String url}) async {
    switch (socialMedia) {
      case "facebook":
        shareOnFacebook(url);
        break;

      case "telegram":
        shareOnTelegram(url);
        break;

      case "instagram":
        globalShare(url);
        break;

      case "linkedin":
        shareOnLinkedIn(url);
        break;

      case "twitter":
        shareOnTwitter(url);
        break;

      case "whatsapp":
        shareOnWhatsApp(url);
        break;

      default:
        break;
    }
  }

  static Future<void> shareOnTelegram(String urlToShare) async {
    final telegramUrl =
        'https://telegram.me/share/url?url=${Uri.encodeComponent(urlToShare)}';
    await _launchUrl(telegramUrl);
  }

  static Future<void> shareOnFacebook(String urlToShare) async {
    final facebookUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(urlToShare)}';
    await _launchUrl(facebookUrl);
  }

  static Future<void> shareOnTwitter(String urlToShare) async {
    final twitterUrl =
        'https://twitter.com/intent/tweet?url=${Uri.encodeComponent(urlToShare)}';
    await _launchUrl(twitterUrl);
  }

  static Future<void> shareOnWhatsApp(String urlToShare) async {
    final whatsappUrl =
        'https://wa.me/?text=${Uri.encodeComponent(urlToShare)}';
    await _launchUrl(whatsappUrl);
  }

  static Future<void> shareOnLinkedIn(String urlToShare) async {
    final linkedInUrl =
        'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(urlToShare)}';
    await _launchUrl(linkedInUrl);
  }

  static Future<void> globalShare(String urlToShare) async {
    await Share.share(urlToShare);
  }

  static Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
