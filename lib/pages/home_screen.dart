import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/pages/main_page.dart';
import 'package:pokeapi/widgets/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.red.shade600,
              Colors.yellow.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.5, 0.9],
          ),
        ),
        child: Stack(
          children: [
            // Fondo con elementos decorativos
            Positioned(
              top: screenSize.height * 0.1,
              left: screenSize.width * 0.1,
              child: _buildPokeballDecoration(0.3),
            ),
            Positioned(
              bottom: screenSize.height * 0.15,
              right: screenSize.width * 0.1,
              child: _buildPokeballDecoration(0.2),
            ),
            Positioned(
              top: screenSize.height * 0.3,
              right: screenSize.width * 0.2,
              child: _buildPokeballDecoration(0.15),
            ),

            // Contenido principal
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logo con animación
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/pokeLogo.png',
                          height: screenSize.height * 0.25,
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Pokédex',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Botón de inicio con mejor estilo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: screenSize.width * 0.80,
                      height: screenSize.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade600,
                            Colors.red.shade800,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          _navigateToMainPage(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.catching_pokemon,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Iniciar Pokédex",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Texto descriptivo
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Descubre y explora todos los Pokémon en tu Pokédex personal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokeballDecoration(double scale) {
    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: 0.1,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade600,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 45),
                height: 10,
                color: Colors.white,
              ),
              Center(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 3,
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

  void _navigateToMainPage(BuildContext context) {
    // Animación al presionar el botón
    _controller.reverse().then((_) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }
}
