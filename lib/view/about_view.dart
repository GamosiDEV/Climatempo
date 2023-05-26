import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    const linkedinUrl =
        "https://www.linkedin.com/in/gabriel-de-moura-silva-2ab729112/";
    const gitUrl = "https://github.com/GamosiDEV";
    const portifolioUrl = "https://www.google.com";

    return Column(
      children: [
        Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/38093698?v=4'),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Linkedin',
                            style: Theme.of(context).textTheme.displaySmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchUrl(Uri.parse(linkedinUrl));
                              },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Git',
                            style: Theme.of(context).textTheme.displaySmall,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchUrl(Uri.parse(gitUrl));
                              },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  text:
                      'Olá meu nome é Gabriel de Moura Silva e eu sou o desenvolvedor deste aplicativo, este que foi feito com o intuito de agregar valor ao meu ',
                  children: [
                    TextSpan(
                      text: 'portifolio',
                      style: const TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          _launchUrl(Uri.parse(portifolioUrl));
                        },
                    ),
                    const TextSpan(
                      text:
                          ', portanto sinta-se avontade para explorar o aplicativo e utiliza-lo, caso queira conhecer mais sobre seu funcionamento acesse o codigo pelo Git a cima, e caso sinta vontade de entrar em contato comigo basta acessar meu Linkedin tambem a cima, fique bem e muito obrigado por baixar meu aplicativo!',
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
