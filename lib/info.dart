import 'package:fashion/details_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Інформація')),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: [
                    const CustomInfoBtn(
                      title: 'ПОЛІТИКА КОНФІДЕНЦІЙНОСТІ',
                      alias: 'policy',
                    ),
                    const CustomInfoBtn(
                      title: 'ПРАВИЛА СПІЛЬНОТИ',
                      alias: 'community',
                    ),
                    const CustomInfoBtn(
                      title: 'ПРАВИЛА КОРИСТУВАННЯ',
                      alias: 'rules',
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Зв'язатися з нами: maksim_zakorko@knu.ua"),
                    ),
                    Container(
                      width: 100,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: MaterialButton(
                          onPressed: () {
                            launch(
                              'https://instagram.com/_casual_outlet_',
                              forceSafariVC: false,
                              forceWebView: false,
                            );
                          },
                          child: const Image(image: AssetImage('assets/inst.png'))
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInfoBtn extends StatefulWidget {
  final String title;
  final String alias;

  const CustomInfoBtn({
    required this.title,
    required this.alias,
    Key? key
  }) : super(key: key);

  @override
  State<CustomInfoBtn> createState() => _CustomInfoBtnState();
}

class _CustomInfoBtnState extends State<CustomInfoBtn> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      minWidth: MediaQuery.of(context).size.width,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black12,
                )
            )
        ),
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          widget.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailsPage(alias: widget.alias))
        );
      },
    );
  }
}
