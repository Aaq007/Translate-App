import 'package:translate/models/text_model.dart';
import 'package:translate/providers/base_provider.dart';
import 'package:translate/services/exceptions.dart';
import 'package:translate/services/status.dart';
import 'package:translate/services/translate_service.dart';

class TranslateViewModel extends BaseViewModel {
  String _language = 'English';
  String get language => _language;

  String? _translatedText;
  String get translatedText => _translatedText!;

  final _translateService = TranslateService.instance;

  void setEndLanguage(String language) {
    _language = language;
    setStatus(Status.idle);
  }

  void translateWord(String text) async {
    setStatus(Status.loading);
    if (text.isNotEmpty) {
      try {
        _translatedText = await _translateService.translate(text, language!);
        setStatus(Status.loaded);
      } on LanguageNotFoundException {
        setStatus(Status.error);
      } catch (e) {
        setStatus(Status.error);
      }
    } else {
      setStatus(Status.idle);
    }
  }
}
