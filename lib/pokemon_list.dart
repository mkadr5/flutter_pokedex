import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:flutter_pokedex/pokemon_detail.dart';
import 'package:http/http.dart' as http;

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Uri uri = Uri.https("raw.githubusercontent.com",
      "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  Pokedex pokedex;
  Future<Pokedex> veri;
  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(uri);
    var decodedJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  /*return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Text(snapshot.data.pokemon[index].name);
                });
                */
                  return GridView.count(
                    crossAxisCount: 2,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      String imgur = poke.img;
                      imgur = imgur.substring(0, 4) + "s" + imgur.substring(4);
                      debugPrint("imgurl yazdır : " + imgur);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                pokemon: poke,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            elevation: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  height: 150,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loading.gif",
                                    image: imgur,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            );
          } else {
            return FutureBuilder(
              future: veri,
              builder:
                  (BuildContext context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  return GridView.extent(
                    maxCrossAxisExtent: 300,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      String imgur = poke.img;
                      imgur = imgur.substring(0, 4) + "s" + imgur.substring(4);
                      debugPrint("imgurl yazdır : " + imgur);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                pokemon: poke,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            elevation: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  height: 150,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loading.gif",
                                    image: imgur,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
