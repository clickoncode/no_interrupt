import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService {
  final String? email;
  DatabaseService({this.email});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("user");



  // save user data
  Future savingUserData(String fullName, String email, String uid) async {
    return await userCollection.doc(email).set({
      "fullName": fullName,
      "createdat": DateTime.now().toString(),
      "email": email,
      "uid": uid,
      "default_channel":'UCFFbwnve3yF62-tVXkTyHqg',
      "channel_id" : '',
      "apikey": "AIzaSyCEy26MdYAe6__ud8Zn6FZyuFLr2TAo9qc",
      "lastactive": '',
    });
  }
  // update app status
  Future lastactive ( String lastactive) async {
    DocumentReference userDocumentReference = userCollection.doc(email);
    return await userDocumentReference.update({
      "lastactive": lastactive,
    });
  }
  Future sendchannel_id ( String channel_id) async {
    DocumentReference userDocumentReference = userCollection.doc(email);
    return await userDocumentReference.update({
      "channel_id": channel_id,
    });
  }
  Future sendapikey(String apikey) async {
    DocumentReference userDocumentReference = userCollection.doc(email);
    return await userDocumentReference.update({
      "apikey":apikey,
    });
  }
  Future updateechannel_id() async {
    DocumentReference userDocumentReference = userCollection.doc(email);
    return await userDocumentReference.update({
      "channel_id": '',
    });
  }




}