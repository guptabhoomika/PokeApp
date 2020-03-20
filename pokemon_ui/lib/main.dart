import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_ui/Pokemon.dart';
import 'package:pokemon_ui/pokeDetail.dart';


void main() => runApp(MaterialApp(
  title: "PokeApp",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
      PokeHub pokeHub;
  @override
  void initState() {
    
    super.initState();
    fetchData();
    //print("2nd work");
  }
  fetchData() async{
      var res = await http.get(url);
      //print(res.body);
      var decodedJson = jsonDecode(res.body);
      pokeHub = PokeHub.fromJson(decodedJson);
      setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Poke App")
          ),
        backgroundColor: Colors.cyan,
      ),

      body:  pokeHub==null ? 
      Center(child: CircularProgressIndicator(),): GridView.count(crossAxisCount: 2,
      children: pokeHub.pokemon.map((poke)=>Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
              onTap:(){ Navigator.push(
                context, 
              MaterialPageRoute(builder: (context)=>PokeDet(pokemon: poke,)));},
                  child: Hero(
                    tag: poke.img,
                                      child: Card(
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                      height: 100,
                      width:100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img)
                        ),
                      ),
                ),
                Text(poke.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
                  ),
        ),
      )).toList(),


     ),

      
      
    );
  }
}