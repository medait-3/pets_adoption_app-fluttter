import 'package:flutter/material.dart';

import '../../Model/pets_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.pets});
  final PetsModel pets;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            color: Color.fromARGB(255, 120, 77, 77),
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.5),
                    Text(
                    pets.name,
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                    Text(
                    pets.description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54

                    ),
                  ),const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ageSexOrigin(pets.age, "Age"),
                          ageSexOrigin(pets.sex, "Sex"),
                          ageSexOrigin(pets.origin, "Origin"),
                        ],
                      ),
                    ),
                  
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                color: pets.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(410),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Center(
                      child: Hero(
                        tag: pets.image,
                        child: Image.asset(
                          pets.image,
                          height: size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  Container ageSexOrigin(value, name) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

                    
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black45,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}
