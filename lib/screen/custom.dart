import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_interrupt/constant/constant.dart';
import '../constant/constant.dart';
import '../local/sf.dart';
import '../services/database.dart';
import 'getvideo_id.dart';

class CustomSection extends StatefulWidget {
  const CustomSection({Key? key}) : super(key: key);
  @override
  State<CustomSection> createState() => _CustomSectionState();
}
class _CustomSectionState extends State<CustomSection> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  bool showselect = false;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(height: 1),
            Text('Note: This App is made for Education purpose only. \n For Business contact : tubevsupport@gmail.com',style: TextStyle(fontSize: 12,),),
            Center(
              child: TextField(
                controller: nameController,
                // obscureText: true,
                // obscuringCharacter: '*',
                decoration: const InputDecoration(

                    hintText: 'Enter API_Key',
                    suffixIcon:Icon(Icons.visibility_off_sharp),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(1),
                        ))

                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("Your key is : ***********" + Constants.API_KEY.split('T').last,style: TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis),)),
                TextButton(
                    onPressed: ()
                    {
                      //
                      String name = nameController.text.trim();
                      if (name.isNotEmpty && name.length >= 30) {
                        setState(()  {
                          DatabaseService(email: user!.email.toString()).sendapikey(name).then((vale) =>  HelperFunctions.saveUserapikey(name));

                          nameController.text = '';
                        });
                        showSnackbar(context, Color(0xfff7f7f8),'API Key Submitted!');
                      }
                      //
                    },
                    child: const Text('Submit')),
                // Text(Constants.API_KEY.toString()),
              ],
            ),
            TextButton(onPressed: (){
              DatabaseService(email: user!.email.toString()).sendapikey(Constants.Defaultkey).then((vale) =>  HelperFunctions.saveUserapikey(Constants.Defaultkey));
              showSnackbar(context, Color(0xfff7f7f8),'Your API Key Reset Sucessfully!');
            }, child: Row(mainAxisAlignment:MainAxisAlignment.start,
    children: [Icon(Icons.restart_alt_sharp,),SizedBox(width: 1,),Text('Reset To default')],)),

            const SizedBox(height: 10),

            TextField(
              controller: contactController,
              decoration: const InputDecoration(
                  hintText: 'Enter Channel Id',
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1),
                      ))),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const getvideo()),
                  );
                }, child: Row(mainAxisAlignment:MainAxisAlignment.start,
                  children: [Icon(Icons.open_in_browser_rounded,),SizedBox(width: 1,),Text('Get Channel Id')],)),
                TextButton(
                    onPressed: () {
                      //
                      String contact = contactController.text.trim();
                      if ( contact.isNotEmpty) {
                        setState(() {
                          Constants.id.add(Contact2( channelid: contact));
                            DatabaseService(email: user!.email.toString()).sendchannel_id(contact);
                          contactController.text = '';

                        });
                      }
                      //
                    },
                    child: const Text('Add')),
              ],
            ),
            const SizedBox(height: 20),
            Constants.id.isEmpty
                ? const Text(
              'No id inserted yet..',
              style: TextStyle(fontSize: 13),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: Constants.id.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            Constants.id[index].channelid[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.id[index].channelid,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //     onTap: () {
              //       //
              //       // contactController.text = Constants.id[index].channelid;
              //       setState(() {
              //         selectedIndex = index;
              //         showselect = true;
              //       });
              //       //
              //     },
              //     child:  showselect?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank)),
              InkWell(
                  onTap: () {
                    //
                    contactController.text = Constants.id[index].channelid;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      Constants.id.removeAt(index);
                      DatabaseService(email: user!.email.toString()).updateechannel_id();
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }

}
class Contact2 {
  String channelid ;
  Contact2({required this.channelid,});
}
// class Contact {
//   String name;
//   String contact;
//   Contact({required this.name, required this.contact});
// }
void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14,),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.red,
      ),
    ),
  );
}