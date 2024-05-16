import 'package:flutter/material.dart';
import 'package:joloondooapp/pages/menu/track/track.dart';

class MainPage extends StatelessWidget {
  final int userId;
  const MainPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/subjectspage');
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 23, bottom: 23, right: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF1a2a5e),
                              width: 0.7,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/duremw.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/practisepage');
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 23, bottom: 23, right: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF1a2a5e),
                              width: 0.7,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/dasgalw.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/examtippage');
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 23, bottom: 23, right: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF1a2a5e),
                              width: 0.7,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/shalgaltw.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackPage(userId: userId),
                            ));
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 23, bottom: 23, right: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF1a2a5e),
                              width: 0.7,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/tuuhw.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:joloondooapp/pages/menu/track/track.dart';

// class MainPage extends StatelessWidget {
//   final int userId;
//   const MainPage({super.key, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   buildImageTap(context, '/subjectspage', 'assets/images/duremr.png'),
//                   buildImageTap(context, '/practisepage', 'assets/images/dasgalr.png'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 children: [
//                   buildImageTap(context, '/examtippage', 'assets/images/shalgaltr.png'),
//                   buildImageTap(
//                     context, 
//                     '/trackpage', // Assuming your route is '/trackpage'
//                     'assets/images/tuuhr.png',
//                     builder: (context) => TrackPage(userId: userId), 
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildImageTap(BuildContext context, String route, String imagePath, {Widget Function(BuildContext)? builder}) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           if (builder != null) {
//             Navigator.push(context, MaterialPageRoute(builder: builder));
//           } else {
//             Navigator.pushNamed(context, route);
//           }
//         },
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(25),
//           child: Image.asset(
//             imagePath,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

