import 'package:flutter/material.dart';


class EditProfiles extends StatefulWidget {
  EditProfiles({super.key});

  @override
  State<EditProfiles> createState() => _EditProfilesState();
}

class _EditProfilesState extends State<EditProfiles> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController img = TextEditingController();

  TextEditingController number = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Center(child: Text("Profilni tahrirlash",style: TextStyle(fontSize: 20),),),
            Divider(),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Itlimos ismingizni togri kiriting";
                        }

                        return null;
                      },
                      controller: firstName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ismingizni kiriting'
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Itlimos familyangizni togri kiriting";
                        }

                        return null;
                      },
                      controller: lastName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Familyangizni kiriting'
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Itlimos telefon raqamingizni togri kiriting";
                        }else{
                          try{
                            int number = int.parse(value);
                          }catch(e){
                            return 'Telefon raqamingizni raqamlar bilan kiriting';
                          }
                        }

                        return null;
                      },
                      controller: number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Telefon raqamingizni kiriting'
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Itlimos profilingiz uchun togri link kiriting";
                        }

                        return null;
                      },
                      controller: img,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Profil surati uchun link kiriting'
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Bekor qilish")),
                        ElevatedButton(onPressed: (){
                          if(formKey.currentState!.validate()){
                            Map<String,dynamic> mp = {
                              'firstName':firstName.text,
                              'lastName':lastName.text,
                              'phoneNumber':number.text,
                              'img':img.text
                            };
                            Navigator.of(context).pop(mp);
                          }
                        }, child: Text("Saqlash")),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
