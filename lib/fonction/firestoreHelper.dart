import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:widget_divers/model/utilisateur.dart';

class firestoreHelper{
  final authBase = FirebaseAuth.instance;

  final instanceFirestore = FirebaseFirestore.instance;
  final firestore_user = FirebaseFirestore.instance.collection('utilisateur');

  final instanceFirestorage = FirebaseStorage.instance;


  // Fonction d'inscription
  Future <User?> inscription(String mail, String password) async{
    final authResult = await authBase.createUserWithEmailAndPassword(email: mail, password: password);
    final user =  authResult.user;
    String identifiant = user!.uid;
    return user;

  }







  // Fonction de connexion
  Future <User> connexion(String mail, String password) async{
    final authResult = await authBase.signInWithEmailAndPassword(email: mail, password: password);
    final user =  authResult.user;
    return user!;
  }

  // Get UID de l'utilisateur
  Future <String> getIdentifiant() async{
    String identifiant =  await authBase.currentUser!.uid;
    //print(identifiant);
    return identifiant;
  }
  
  addUser(Map <String,dynamic> map, String uid){
    print('toto');
    firestore_user.doc(uid).set(map);
    print('titi');
  }

  Future <Utilisateur> getUtilisateur(String uid) async{
    print("toto");
    print("uid :");
    print(uid);
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('utilisateur').doc(uid).get();
    print("tata");
    return Utilisateur(snapshot);
  }
}