import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/pages/main_page.dart';
import 'package:pokeapi/widgets/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.fadeColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(height: screenSize.height * 0.40,'assets/images/pokeLogo.png'),
                SizedBox(
                  width: screenSize.width * 0.90,
                  height: screenSize.height * 0.10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    },
                    child: Text("Iniciar Pokedex", style: TextStyle(color: AppColors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
