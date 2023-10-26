import 'package:url_launcher/url_launcher.dart';
import 'package:fourlinkmobileapp/helpers/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:fourlinkmobileapp/models/providers/utils_provider.dart';
class WhatsappMessage{
  Future launchWhatsapp(context,[text]) async {
    var url = "";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await FN_showDetails_Dialog(context,translator.translate('sorry'),translator.translate('whatsapp_error'));
      throw 'Could not launch $url';
    }
  }
}