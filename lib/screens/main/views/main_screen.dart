import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel/screens/main/views/station/blocs/station_bloc.dart';
import 'package:kaerel/screens/main/views/home/views/home_screen.dart';
import 'package:kaerel/screens/main/views/settings/views/settings_screen.dart';
import 'package:kaerel/screens/main/views/station/views/station_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: KaerelColor.green2,
              bottom: PreferredSize(
                preferredSize:
                    const Size.fromHeight(36.0), // here the desired height
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          36,
                        ),
                        color: KaerelColor.green1,
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        labelColor: KaerelColor.green1,
                        unselectedLabelColor: Colors.white,
                        indicator: BoxDecoration(
                          border:
                              Border.all(color: KaerelColor.green1, width: 6),
                          borderRadius: BorderRadius.circular(
                            36,
                          ),
                          color: Colors.white,
                        ),
                        tabs: const [
                          Tab(
                            text: 'Jadwal',
                          ),
                          Tab(
                            text: 'Stasiun',
                          ),
                          Tab(
                            text: 'Settings',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => StationBloc()..add(GetStation()),
                child: HomeScreen(),
              ),
              BlocProvider(
                create: (context) => StationBloc()..add(GetStation()),
                child: StationScreen(),
              ),
              SettingsScreen(),
            ],
          ),
        ));
  }
}
