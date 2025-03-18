import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spaced/utils/theme_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class SpacedPage extends HookWidget {
  const SpacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputController = useTextEditingController(
      text: 'My text is more aesthetic than yours.',
    );
    final outputController = useTextEditingController(
      text: inputController.text.characters.join(' '),
    );
    final outputController2 = useTextEditingController(
      text: inputController.text.characters.join('  '),
    );

    useEffect(
      () {
        void listener() {
          outputController.text = inputController.text.characters.join(' ');
        }

        inputController.addListener(listener);
        return () => inputController.removeListener(listener);
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              launchUrl(Uri.parse('https://github.com/LuckUVeryX/spaced'));
            },
            icon: const FaIcon(FontAwesomeIcons.github),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text(
            'Spaced Generator',
            style: context.textTheme.displayMedium?.copyWith(
              color: context.colorScheme.primary,
              letterSpacing: 16,
            ),
          ),
          Text(
            'Generate Spaced Aesthetic Text',
            style: context.textTheme.displayMedium?.copyWith(letterSpacing: 16),
          ),
          const SizedBox(height: 48),
          TextField(
            maxLines: null,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            controller: inputController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const FaIcon(Icons.clear),
                onPressed: inputController.clear,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: null,
            readOnly: true,
            controller: outputController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const FaIcon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: outputController.text),
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Copied')));
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: null,
            readOnly: true,
            controller: outputController2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const FaIcon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: outputController2.text),
                  );
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Copied')));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
