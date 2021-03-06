import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate/providers/language_provider.dart';
import 'package:translate/services/languages.dart';
import 'package:translate/services/status.dart';

class TextTranslatepage extends StatefulWidget {
  const TextTranslatepage({Key? key}) : super(key: key);

  @override
  _TextTranslatepageState createState() => _TextTranslatepageState();
}

class _TextTranslatepageState extends State<TextTranslatepage> {
  String dropDownValue = 'English';
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate'),
        centerTitle: true,
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25.0,
          ),
          Flexible(
            child: TextField(
              controller: _textController,
              textAlign: TextAlign.center,
              expands: false,
              maxLines: 12,
              minLines: null,
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter text to translate',
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text(
              'Translate to:',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Consumer<TranslateViewModel>(
            builder: (_, languageProvider, __) => Center(
              child: DropdownButton(
                items: languagesMap.keys
                    .map((String value) => DropdownMenuItem<String>(
                        value: value, child: Text(value)))
                    .toList(),
                value: languageProvider.language,
                onChanged: (value) =>
                    languageProvider.setEndLanguage(value.toString()),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Consumer<TranslateViewModel>(
            builder: (_, languageProvider, __) => Center(
              child: ElevatedButton(
                child: const Text(
                  'Translate',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  (_textController.text.isNotEmpty)
                      ? languageProvider.translateWord(_textController.text)
                      : null;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Consumer<TranslateViewModel>(
                  builder: (_, languageProvider, __) =>
                      (languageProvider.currentStatus == Status.idle)
                          ? Container()
                          : (languageProvider.currentStatus == Status.error)
                              ? const Text('Language not identified')
                              : (languageProvider.currentStatus ==
                                      Status.loading)
                                  ? const Text('Loading')
                                  : SelectableText(
                                      languageProvider.translatedText!)),
            ),
          ),
        ],
      ),
    );
  }
}
