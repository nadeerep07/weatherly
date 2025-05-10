import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/navigation_cubit.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/view/favorites_screen.dart';
import 'package:weather_app/view/search_screen.dart';
import 'package:weather_app/widgets/build_weather_content.dart';
import 'package:weather_app/widgets/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final isDaytime = DateTime.now().hour >= 6 && DateTime.now().hour < 18;
    final colors =
        isDaytime
            ? [Colors.blue.shade300, Colors.blue.shade700]
            : [Colors.indigo.shade900, Colors.black];

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: isDaytime ? Colors.black : Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient:
                  isDaytime ? AppColors.dayGradient : AppColors.nightGradient,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: isDaytime ? Brightness.dark : Brightness.light,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: colors,
            ),
          ),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return BlocBuilder<NavigationCubit, int>(
                builder: (context, currentIndex) {
                  return IndexedStack(
                    index: currentIndex,
                    children: [
                      BuildWeatherContent(context: context, colors: colors, isDaytime: isDaytime, state: state),
                      const SearchScreen(),
                      const FavoritesScreen(),
                    ],
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: isDaytime ? Colors.blue.shade700 : Colors.black,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade400,
              onTap: (index) {
                context.read<NavigationCubit>().updateIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: 'Weather',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
