import 'package:dars_29_home/models/user.dart';
import 'package:dars_29_home/views/widgets/edit_profiles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user = User(firstName: 'Yulchiyev', lastNaem: 'Bori', phoneNumber: '9999999999999', img: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: user.img == '' ? Colors.grey : null,
                  image: user.img == '' ? null : DecorationImage(image: NetworkImage("${user.img}")),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Text("${user.firstName}  ${user.lastNaem}",style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () async{
                    Map<String,dynamic> mp = await showModalBottomSheet(context: context, builder: (ctx){
                      return EditProfiles();
                    });
                    if(mp != null){
                      user.firstName = mp['firstName'];
                      user.lastNaem = mp['lastName'];
                      user.phoneNumber = mp['phoneNumber'];
                      user.img = mp['img'];
                      setState(() {});
                    }
                  }, icon: Icon(Icons.edit))],),
                  SizedBox(height: 20,),
                  Text("Telefon raqam: ${user.phoneNumber}",style: TextStyle(fontSize: 17,),)
                ],
              )
            ],
          )
        ],
    );
  }
}
