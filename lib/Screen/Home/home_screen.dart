import 'package:flutter/material.dart';

import '../../Model/pets_model.dart';
import '../Detail/detail.dart';

class PetsHomeScreen extends StatefulWidget {
  const PetsHomeScreen({super.key});

  @override
  State<PetsHomeScreen> createState() => _PetsHomeScreenState();
}

class _PetsHomeScreenState extends State<PetsHomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<List<PetsModel>> categories = [cats, dogs, birds, snakes, other];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            categorySelection(),
            selectedIndex < categoryList.length
                ? (Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: SizedBox(
                      height: 570,
                      child: ListView.builder(
                          itemCount: categories[selectedIndex].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      pets: categories[selectedIndex][index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, right: 15),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      height: 50,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: categories[selectedIndex]
                                                  [index]
                                              .color,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 230,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 230,
                                      child: Center(
                                        child: Hero(
                                          tag: categories[selectedIndex]
                                                  [index]
                                              .image,
                                          child: Image.asset(
                                            categories[selectedIndex]
                                                    [index]
                                                .image,
                                            fit: BoxFit.cover,height: 190,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(bottom: 25,left: 80,
                                      child: Text(
                                              categories[selectedIndex]
                                                      [index]
                                                  .name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 30,),
                                              ),
                                    ),
                                    Positioned(bottom: 10,left: 80,
                                      child: Text(
                                              categories[selectedIndex]
                                                      [index]
                                                  .breed,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                    ),
                                    Positioned(top: 45,left: 5,
                                      child: Column(
                                              children: [
                                                Text(
                                                  categories[selectedIndex]
                                                          [index]
                                                      .sex,
                                                  style: const TextStyle(
                                                        fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(
                                                  "${categories[selectedIndex][index].age} year old",
                                                  style: const TextStyle(
                                                    fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold
                                                    
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ))
                : const SizedBox(),
          ],
        ),
      )),
    );
  }

  SizedBox categorySelection() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Column(
                children: [
                  ClipRRect(    borderRadius: BorderRadius.circular(21),
                    child: Container(
                      width: 80,
                        color: selectedIndex == index
                                            ?   Color.fromARGB(255, 120, 77, 77)
                                            : Color.fromARGB(255, 247, 246, 246),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Center(
                          child: Text(
                            categoryList[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
