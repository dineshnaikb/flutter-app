import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  return runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'test app',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: const Color.fromARGB(255, 255, 174, 0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                              'https://i0.wp.com/recommendmeanime.com/wp-content/uploads/2016/06/One-Piece-Anime-Hero-Image-free-wallpaper-hd.jpg?fit=1366%2C768&ssl=1'),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(0.4),
                              child: Column(
                                children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  Clan Name: Lorem lpsum',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  28 members, 5 online',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 4.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '  Achievements',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Table(
                      textDirection: TextDirection.ltr,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: const [
                        TableRow(
                          children: [
                            Text(
                              '  Current league',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                textDirection: TextDirection.ltr,
                                size: 120,
                                Icons.shield,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        TableRow(children: [
                          Text(
                            '  League ranking',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '11th',
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 0),
                            child: Text(
                              '  Experience',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ' 2000 xp',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                      ],
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 4.0,
                    ),
                    const Text(
                      ' Past featured performances',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(4),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              'https://i.pinimg.com/550x/0e/51/7e/0e517eb57cb5a992ef3230b0e0d792af.jpg',
                              height: 100,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              ' priya in international Debating League',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              'https://i.pinimg.com/550x/0e/51/7e/0e517eb57cb5a992ef3230b0e0d792af.jpg',
                              height: 100,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              ' Akshay in Global Quizzing finals',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "see more",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 4.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        ' Live clan activites on platform',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 190.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                            image: const DecorationImage(
                                image:  NetworkImage(
                                    "https://img.freepik.com/premium-photo/dark-street-background-reflection-blue-red-neon-asphalt_129911-31.jpg"),
                                fit: BoxFit.fill)),
                        child: const Center(
                          child: Text(
                            '  Live trading \nchampionship',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 190.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                            image: const DecorationImage(
                                image:  NetworkImage(
                                    "https://img.freepik.com/premium-photo/dark-street-background-reflection-blue-red-neon-asphalt_129911-31.jpg"),
                                fit: BoxFit.fill)),
                        child: const Center(
                          child: Text(
                            '  Treasure hunt',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "see more",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 4.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        ' Clan discussions',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      ' General Thread:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' 15 unread messages',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      ' (Live) Anyone enthu for trading league..',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' 10 unread messages',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      ' (Live) Anyone enthu for trading league..',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' 10 unread messages',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "see more",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      thickness: 4.0,
                    ),
                    const Text(
                      ' Clan members',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(4),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.nicepng.com/png/detail/838-8382821_matt-round-png-round-image-of-man.png'),
                                    ),
                                  ))),
                          const Text(
                            'Lorem ipsum - Clan head',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          const Text(
                            'Lorem ipsum - Clan head',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 65,
              color: Colors.black,
              child: GNav(
                rippleColor:
                    Colors.black, // tab button ripple color when pressed
                hoverColor: Colors.black, // tab button hover color
                haptic: true, // haptic feedback
                tabBorderRadius: 15,
                tabActiveBorder: Border.all(
                    color: Colors.black, width: 1), // tab button border
                //tabBorder:
                //    Border.all(color: Colors.grey, width: 1), // tab button border
                tabShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.9), blurRadius: 8)
                ], // tab button shadow
                curve: Curves.easeOutExpo, // tab animation curves
                duration: const Duration(milliseconds: 900), // tab animation duration
                gap: 8, // the tab button gap between icon and text
                color: Colors.grey[800], // unselected icon color
                activeColor: Colors.white, // selected icon and text color
                iconSize: 24, // tab button icon size
                tabBackgroundColor: Colors.white
                    .withOpacity(0.1), // selected tab background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5), // navigation bar padding
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.star,
                    iconColor: Colors.white,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.bar_chart,
                    iconColor: Colors.white,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.groups,
                    iconColor: Colors.white,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.account_circle_rounded,
                    iconColor: Colors.white,
                    text: 'Profile',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
