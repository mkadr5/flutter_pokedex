import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Color baskinRenk;
  PaletteGenerator paletteGenerator;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    String imgur = widget.pokemon.img;
    imgur = imgur.substring(0, 4) + "s" + imgur.substring(4);
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(
      NetworkImage(imgur),
    );
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return dikeyBody(context);
          } else {
            return yatayBody(context);
          }
        },
      ),
    );
  }

  Stack dikeyBody(BuildContext context) {
    String imgur = widget.pokemon.img;
    imgur = imgur.substring(0, 4) + "s" + imgur.substring(4);
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (7 / 10),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Height : " + widget.pokemon.height,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Weight : " + widget.pokemon.height,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Types  ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pokemon.type
                      .map((e) => Chip(
                          backgroundColor: Colors.deepOrange.shade300,
                          label: Text(
                            e,
                            style: TextStyle(color: Colors.white),
                          )))
                      .toList(),
                ),
                Text(
                  "Next Evolution  ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((e) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                e.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("Son hali")],
                ),
                Text(
                  "Weakness ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((e) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                e,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("Zayıflığı yok")],
                ),
                Text(
                  "Prev Evolution : ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((e) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                e.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("İlk hali yok")],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 200,
              height: 200,
              child: Image.network(
                imgur,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget yatayBody(BuildContext context) {
    String imgur = widget.pokemon.img;
    imgur = imgur.substring(0, 4) + "s" + imgur.substring(4);
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(
                  imgur,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Height : " + widget.pokemon.height,
                  ),
                  Text(
                    "Weight : " + widget.pokemon.height,
                  ),
                  Text(
                    "Types  ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.type
                        .map((e) => Chip(
                            backgroundColor: Colors.deepOrange.shade300,
                            label: Text(
                              e,
                              style: TextStyle(color: Colors.white),
                            )))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution  ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((e) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  e.name,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("Son hali")],
                  ),
                  Text(
                    "Weakness ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((e) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  e,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("Zayıflığı yok")],
                  ),
                  Text(
                    "Prev Evolution : ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((e) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  e.name,
                                  style: TextStyle(color: Colors.white),
                                )))
                            .toList()
                        : [Text("İlk hali yok")],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
