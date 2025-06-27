import 'package:url_launcher/url_launcher.dart';

class Util {
  static void launchBrowserURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir el enlace: $url';
    }
  }
}
