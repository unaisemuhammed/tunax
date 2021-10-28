import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/MusicPages/SettingsPage.dart';
import 'package:musicplayer/PageManager.dart';
import 'BottomBar.dart';
import 'FavouritePage.dart';
import 'FolderPage.dart';
import 'PlaylistPage.dart';
import 'SearchPage.dart';
import 'TrackPage.dart';
import 'package:musicplayer/colors.dart' as AppColors;

var _pages = [Track(), Favourite(), Playlist(int)];
List Title = ["Playlist", "Track", "Favourite", "Folder"];

class SlidePage extends StatefulWidget {
  const SlidePage({Key? key}) : super(key: key);

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  int play = 0;
  int favourite = 0;
  TextEditingController playlistController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double Heights = MediaQuery.of(context).size.height;
    final double Weights = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.back,
          appBar: AppBar(
            bottom: TabBar(
              dragStartBehavior: DragStartBehavior.down,
              tabs: [
                Tab(
                  text: "Track",
                ),
                Tab(
                  text: "Favourite",
                ),
                Tab(
                  text: "Playlist",
                ),
                // Tab(
                //   text: "Folder",
                // ),
              ],
              indicatorColor: Colors.white70,
              unselectedLabelColor: Colors.white60,
              unselectedLabelStyle:
              TextStyle(fontSize: 16, fontFamily: "Titil"),
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontFamily: "Titil",
                  fontWeight: FontWeight.w500),
            ),
            toolbarHeight: 70,
            elevation: 0,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text(
              //               "Create Playlist",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 23,
              //                   fontFamily: "Titil",
              //                   fontWeight: FontWeight.w700),
              //             ),
              //             content: TextField(
              //               style: TextStyle(
              //                 color: Colors.white,
              //               ),
              //             ),
              //             actions: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 children: [
              //                   Container(
              //                     alignment: Alignment.bottomLeft,
              //                     child: TextButton(
              //                       onPressed: () {
              //                         Navigator.pop(context);
              //                       },
              //                       child: Text(
              //                         "Cancel",
              //                         style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 20,
              //                             fontFamily: "Titil"),
              //                       ),
              //                     ),
              //                   ),
              //                   Container(
              //                     alignment: Alignment.bottomRight,
              //                     child: TextButton(
              //                       onPressed: () {},
              //                       child: Text(
              //                         "Create",
              //                         style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 20,
              //                             fontFamily: "Titil"),
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ],
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20)),
              //             backgroundColor: AppColors.back,
              //           );
              //         });
              //     print(playlistController);
              //   },
              //   icon: Icon(Icons.playlist_add),
              // ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search(),
                      ));
                },
                icon: Icon(Icons.search),
                iconSize: 30,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settigs(),
                      ),
                    );
                  },
                  icon: Icon(Icons.settings),
                  iconSize: 25),
            ],
            title: Text(
              "TUNE " "Ax",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Gemunu',
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppColors.back,
          ),

          ///PageView///
          body: Stack(
            children: [
              TabBarView(
                children: _pages,
              ),

              /// ///////MusicBottomBar/////// ///
              // Positioned(
              //     bottom: Heights / 100,
              //     right: 7,
              //     left: 7,
              //     height: Heights / 13,
              //     child: BottomBar()),

              ///ShadedPart///
              Positioned(
                top: Heights / 2000,
                right: 0,
                left: 0,
                height: Heights / 25,
                child: Container(
                  child: ColorFiltered(
                    colorFilter:
                    ColorFilter.mode(AppColors.back, BlendMode.srcOut),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.shade,
                              backgroundBlendMode: BlendMode.dstOut),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: Heights,
                          width: Weights,
                          decoration: BoxDecoration(
                            color: AppColors.shade,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:audio_service/audio_service.dart';
// import 'package:get_it/get_it.dart';
// import 'PageManager.dart';
// import 'audioHandler.dart';
// GetIt getIt = GetIt.instance;
// Future<void> setupServiceLocator() async {
//   // services
//   getIt.registerSingleton<AudioHandler>(await initAudioService());
//   // page state
//   getIt.registerLazySingleton<PageManager>(() => PageManager());
// }
