import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tally_screen/bloc/user_bloc.dart';
import 'package:tally_screen/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_event.dart';
import '../models/guide_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            
            //implement offline state handling
          },
          builder: (context, state) {
            if (state.user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.vertical,
              children: [
                generalGreetingText(greet: state.greeting, name: state.user!.name),
                if(state.user!.onboardingDone == true && state.hasCheckedIn == true)
                  resuableQuoteLine(
                    quoteLine: state.quoteMessage?.title ??
                      "It's a quiet one")
                else
                  resuableQuoteLine(quoteLine: "Its a quiet one"),
                SizedBox(height: 40),

                //BELOW IS CHECK_IN CONTAINER
                resusableSectionTitle(title: "THIS WEEK"),
                SizedBox(height: 20),
                if (state.user!.onboardingDone == false)
                  resuableCheckinCard(
                    title: "Your first check-in.",
                    description: "Five minutes. There's no wrong answer here.",
                    checkedin: state.hasCheckedIn,
                  )
                else if (state.hasCheckedIn == false)
                  resuableCheckinCard(
                    title: "Five quiet minutes.",
                    description: "Your weekly check-in is ready when you are. No pressure to do it now.",
                    checkedin: state.hasCheckedIn,
                  )
                else
                  resuableCheckinCard(
                    title: state.quoteMessage?.title ?? "Done for this week.",
                    description: state.quoteMessage?.description ?? "Thank you for checking in with yourself.",
                    checkedin: state.hasCheckedIn,
                  ),
                SizedBox(height: 40),

                //BELOW ARE YOUR STILL PENDING TO READ GUIDES                      
                if (state.pendingGuides.isNotEmpty) ...[
                  resusableSectionTitle(
                    title: "PICK UP WHERE YOU LEFT OFF",
                  ),
                  const SizedBox(height: 20),
                  ...buildGuideCards(
                    state.pendingGuides,
                  ),
                ],

                //BELOW ARE WEEKLY GUIDES (CHANGES EVERY WEEK)                      
                if (state.thisWeekGuides.isNotEmpty) ...[
                  resusableSectionTitle(
                    title: "THIS WEEK'S GUIDE",
                  ),
                  const SizedBox(height: 20),
                  ...buildGuideCards(
                    state.thisWeekGuides,
                  ),
                ],

                //BELOW ARE GUIDES ACCORDING TO USER MOOD:                     
                if (state.moodGuides.isNotEmpty) ...[
                  resusableSectionTitle(
                    title: "FROM YOUR GUIDES",
                  ),
                  const SizedBox(height: 20),
                  ...buildGuideCards(
                    state.moodGuides,
                  ),
                ],

                // SizedBox(height: 20),
                // resuableGuideCard(
                //   imageurl: "assets/guide1.png",
                //   title: "The first sleepless month",
                //   description: "A short read on what no one tells you. 6 min.",
                // ),
              ],
            );
          },
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
              label: ' ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Smile.svg', width: 28, height: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Group.svg', width: 28, height: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Book.svg', width: 28, height: 28),
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
      ),
    );
  }
}

List<Widget> buildGuideCards(
  List<GuideModel> guides,
) {
  return guides.map(
    (guide) => Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: resuableGuideCard(
        imageurl: guide.imageUrl,
        title: guide.title,
        description: guide.description,
      ),
    ),
  ).toList();
}

Row resuableQuoteLine({required String quoteLine}) {
  return Row(
    children: [
      // SizedBox(width: 20,),
      Expanded(
        child: Text(
          quoteLine,
          style: GoogleFonts.caveat(
            color: Color.fromRGBO(115, 115, 115, 1),
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Row generalGreetingText({required String greet, required String name}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Text.rich(
          TextSpan(
            style: GoogleFonts.newsreader(
              fontSize: 40,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(text: '$greet ,'),
              TextSpan(
                text: name,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row resusableSectionTitle({required String title}) {
  return Row(
    children: [
      // SizedBox(width: 20,),
      Expanded(
        child: Text(
          title,
          style: GoogleFonts.workSans(
            color: const Color.fromRGBO(153, 153, 153, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
      ),
    ],
  );
}

Container resuableCheckinCard({
  required String title,
  required String description,
  required bool checkedin,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
    color: Colors.white,
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
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
                description,
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
        if (!checkedin)
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    context.read<UserBloc>().add(CompleteCheckIn("sad"),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [Text("Begin"), Icon(Icons.navigate_next)],
                  ),
                ),
              );
            },
          ),
      ],
    ),
  );
}

Container resuableGuideCard({
  required String imageurl,
  required String title,
  required String description,
}) {
  return Container(
    padding: EdgeInsets.all(0),
    child: Column(
      children: [
        Image.network(width: double.infinity, imageurl, fit: BoxFit.cover),
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
