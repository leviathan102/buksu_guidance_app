import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  static String route = "about";
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  final datasets = <String, dynamic>{};
  final double opacity = 0.2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Guidance Office'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        //elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent[400]),
          onPressed: () {
            //passing to root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              ),
              gradient: const RadialGradient(
                center: Alignment.center,
                radius: 1,
                colors: <Color>[Color(0xFF4FC3F7), Color(0xFFB2EBF2)],
                stops: [0, 1],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Image.network(
                        '''https://buksu.edu.ph/wp-content/uploads/2021/01/university-guidance-center-faq-banner.png''',
                        width: double.maxFinite,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          ''' The University Guidance Center aims to help the University achieve its vision and mission by conceptualizing,coordinating and implementing the different activities of the College based Guidance Offices to facilitate the student’s growth process and wellbeing through its programs and services.The Guidance Center aims to develop a well balanced and mentally sound student capable of achieving their full potential through a comprehensive and socially sensitive guidance and counseling programs.''',
                          style: TextStyle(
                            color: Color(0xFFFDFBFB),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
