//this is just to show UI preview 
//refer to home_screen

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _MyAppState();
}

class _MyAppState extends State<Preview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(115, 115, 115, 0),
          actions: [
            Container(
              color: Colors.black,
              height: 40,
              width: 40,
              child: Center(
                child: Text(
                  "T",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
          title: Text(
            "DALL",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xF5F5F5F5),
        body: ListView(
          padding: EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                // SizedBox(width: 20,),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.newsreader(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(text: 'Morning, '),
                        TextSpan(
                          text: 'Harsh',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            Row(
              children: [
                // SizedBox(width: 20,),
                Expanded(
                  child: Text(
                    "Its a quiet one",
                    style: GoogleFonts.caveat(
                      color: Color.fromRGBO(115, 115, 115, 1),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            resusableSectionTitle(title: "THIS WEEK"),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Five quiet minutes.",
                          style: GoogleFonts.newsreader(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Your weekly check-in is ready when you are. No pressure to do it now.",
                          style: GoogleFonts.workSans(
                            color: Color.fromRGBO(115, 115, 115, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Begin"),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            resusableSectionTitle(title: "THIS WEEK'S GUIDE"),
            SizedBox(height: 20),
            resuableContainer(
              imageurl: "assets/guide1.png",
              title: "The first sleepless month",
              description: "A short read on what no one tells you. 6 min.",
            ),

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          fixedColor: Color.fromRGBO(115, 115, 115, 1),
          currentIndex: 0,
          backgroundColor: Color.fromRGBO(115, 115, 115, 1),
          // selectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Layoutblocks.svg',
                width: 28,
                height: 28,
              ),
              label: ' '
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Smile.svg',
                width: 28,
                height: 28,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Group.svg',
                width: 28,
                height: 28,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Book.svg',
                width: 28,
                height: 28,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/Settings.svg',
                width: 28,
                height: 28,
              ),
              label: '',
            ),
          ],
        ),
      );
  }
}

Row resusableSectionTitle({required String title}){
  return Row(
    children: [
      // SizedBox(width: 20,),
      Expanded(
        child: Text(
          title,
          style: GoogleFonts.workSans(
            color: const  Color.fromRGBO(153, 153, 153, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 5,
          ),
        ),
      ),
    ],
  );
}
Container resuableContainer({required String imageurl, required String title, required String description}) {
  return Container(
    padding: EdgeInsets.all(0),
    child: Column(
      children: [
        Image.asset(
          width: double.infinity,
          imageurl,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                description,
                style: GoogleFonts.workSans(
                  color: Color.fromRGBO(115, 115, 115, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}