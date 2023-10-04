import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.pushReplacementNamed(context, '/regionListScreen');
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/kImgLandingPage.jpg',
              fit: BoxFit.cover,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pokedex',
                  style: TextStyle(
                    color: Color(0xFFFFCE00),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'PokemonFont',
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Color(0xFF3E72BF),
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Double-tap to proceed',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
