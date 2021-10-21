import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widget_divers/model/utilisateur.dart';
import 'package:widget_divers/fonction/firestoreHelper.dart';

class page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pageState();
  }

}

class pageState extends State<page>{
  late Utilisateur user;
  late String identifiant;

  void initUser() async{
    identifiant = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot documentSnapshot= await FirebaseFirestore.instance.collection("utilisateur").doc(identifiant).get();
    user = Utilisateur(documentSnapshot);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle
          ),
          child: (user.image==null)?Image.asset("assets/images/geophotos2.png",fit: BoxFit.fill,):Image.network(user.image,fit: BoxFit.fill,),
        ),
        Text("${user.nom}  ${user.prenom}"),
        Text(user.pseudo),
        Text(user.nom),
        Text(user.nom),
        Text(user.nom),
        Text(user.nom),
      ],
    );
  }
}