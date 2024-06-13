import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var apiUrl =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  List? pokedex;

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJson = jsonDecode(value.body);
        pokedex = decodedJson['pokemon'];
        print(pokedex?[0]['name']);
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                top: -50,
                right: -50,
                child: Image.asset(
                  'images/pokeball.png',
                  width: 200,
                  fit: BoxFit.fitWidth,
                )),
            const Positioned(
              top: 80,
              left: 20,
              child: Text(
                "Pokedex",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Positioned(
              top: 150,
              bottom: 0,
              width: mediaQuery.width,
              child: Column(
                children: [
                  pokedex != null
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.4),
                              itemCount: pokedex?.length,
                              itemBuilder: (context, index) {
                                var type = pokedex?[index]['type'][0];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: pokedex?[index]['type'][0] == "Grass" ? Colors.greenAccent : pokedex?[index]['type'][0] == "Fire" ? Colors.redAccent
                                : pokedex?[index]['type'][0] == "Water" ? Colors.blue : pokedex?[index]['type'][0] == "Poison" ? Colors.deepPurpleAccent
                                : pokedex?[index]['type'][0] == "Electric" ? Colors.amber : pokedex?[index]['type'][0] == "Rock" ? Colors.grey
                                : pokedex?[index]['type'][0] == "Ground" ? Colors.brown : pokedex?[index]['type'][0] == "Psychic" ? Colors.indigo
                                : pokedex?[index]['type'][0] == "Fighting" ? Colors.orange : pokedex?[index]['type'][0] == "Bug" ? Colors.lightGreenAccent
                                : pokedex?[index]['type'][0] == "Ghost" ? Colors.deepPurple : pokedex?[index]['type'][0] == "Normal" ? Colors.black26 : Colors.pink,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset(
                                              'images/pokeball.png',
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            )),
                                        Positioned(
                                            top: 20,
                                            left: 10,
                                            child: Text(
                                              pokedex?[index]['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            )),
                                        Positioned(
                                            top: 50,
                                            left: 20,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.black26,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    top: 4.0,
                                                    bottom: 4.0),
                                                child: Text(
                                                  type.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: CachedNetworkImage(
                                            imageUrl: pokedex?[index]['img'],
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                ],
              ),
            )
          ],
        ));
  }
}
