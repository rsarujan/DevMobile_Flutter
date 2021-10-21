import 'package:flutter/material.dart';
import 'package:widget_divers/infouser2.dart';
import 'package:widget_divers/model/utilisateur.dart';

import 'fonction/firestoreHelper.dart';

class informationUser extends StatefulWidget{
  late String mail;
  informationUser({required String this.mail});
  /*late String prenom;
  informationUser({required String this.prenom});*/

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return informationUserState();
  }

}

class informationUserState extends State<informationUser>{
  String nom='';
  String pseudo='';
  String prenom='';
  String adresse='';
  bool jeuxvideo = false;
  bool lecture=false;
  bool sport=false;
  bool reseauxSociaux=false;
  bool isMan=true;
  List loisirs=[];
  String identifiant='';

  //Utilisateur user = Utilisateur.vide();
  Utilisateur user = Utilisateur.vide();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firestoreHelper().getIdentifiant().then((value) {
      identifiant = value;
      print('TESTESSSSSS');
      /*firestoreHelper().getUtilisateur(identifiant).then((value) {
        setState(() {
          user = value;
          print('User: ');
          print(user);
        });
        print(user.nom);
      });*/
    });
    print('Id:');
    print(identifiant);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information personnels'),
        //title: Text(user.prenom)
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(

          children: [
            //sexe
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Femme'),
                Switch.adaptive(
                    value: isMan,
                    onChanged: (bool value){
                      setState(() {
                        isMan = value;
                      });
                    }
                ),
                Text('Homme')

              ],
            ),

            //nom
            TextField(
              onChanged: (String value){
                setState(() {
                  nom = value;


                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Nom"
              ),

            ),
            SizedBox(height: 20,),
            //prenom
            TextField(
              onChanged: (String value){
                setState(() {
                  prenom = value;


                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Prenom"
              ),

            ),
            SizedBox(height: 20,),
            //pseudo
            TextField(
              onChanged: (String value){
                setState(() {
                  pseudo = value;


                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Pseudo"
              ),

            ),
            //adresse
            SizedBox(height: 20,),
            TextField(
              onChanged: (String value){
                setState(() {
                  adresse = value;


                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Adresse"
              ),

            ),
            SizedBox(height: 20,),


            CheckboxListTile(
              title: Text('Jeux vidéos'),
              onChanged: (bool? value){
                setState(() {
                  jeuxvideo = value!;
                });
              },
              value: jeuxvideo,


            ),
            CheckboxListTile(
              title: Text('lecture'),
              onChanged: (bool? value){
                setState(() {
                  lecture = value!;
                });
              },
              value: lecture,


            ),
            CheckboxListTile(
              title: Text('sport'),
              onChanged: (bool? value){
                setState(() {
                  sport = value!;
                });
              },
              value: sport,


            ),
            CheckboxListTile(
              title: Text('Réseaux sociaux'),
              onChanged: (bool? value){
                setState(() {
                  reseauxSociaux = value!;
                });
              },
              value: reseauxSociaux,


            ),

            ElevatedButton(



                onPressed: (){
                  //création de la liste

                  ajouterliste(jeuxvideo,loisirs,"Jeux Videos");
                  ajouterliste(sport,loisirs,"Sport");
                  ajouterliste(reseauxSociaux,loisirs,"Réseaux sociaux");
                  ajouterliste(lecture,loisirs,"lecture");

                  //créattion de la map
                  Map<String,dynamic> map ={
                    "nom":nom,
                    "prenom":prenom,
                    "adresse":adresse,
                    "isMan":isMan,
                    "loisirs":loisirs
                  };

                  //Enregistrement dans la base du donnée
                  firestoreHelper().addUser(map, identifiant);

                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return page();
                      }
                  ));

                },
                child: Text('Enregistrer')
            ),

          ],
        ),
      ),
    );

  }
  List ajouterliste(bool element, List list, String valeur){
    if(element){
      list.add(valeur);
    }

    return  list;

  }
}