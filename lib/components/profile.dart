
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:the_pixel_pioneers/components/edit_profile.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileSection(),
        Resumes(),
        TextButton(onPressed: () => Authentication.auth.signOut(), child: Text("Log Out"))
      ],
    );
  }
}

class Resumes extends StatelessWidget {
  const Resumes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("My Resumes"),
                  Spacer(),
                  IconButton(onPressed: () => {}, icon: Icon(Icons.add))
                ],
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image(image: AssetImage("assets/images/placeholder.png"), width: 50),
                    Text("Optimizely"),
                    Spacer(),
                    IconButton(
                        onPressed: () async => await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => Modal()
                        ),
                        icon: Icon(Icons.menu),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () => {},
              child: Text("Preview Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent.shade700),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
          TextButton(
              onPressed: () => {},
              child: Text("Edit Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
          TextButton(
              onPressed: () => {},
              child: Text("Delete Resume"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent.shade400),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              )
          ),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  String name = "Bertram Gilfoyle";
  String profession = "Software Engineer";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(image: AssetImage("assets/images/placeholder.png"), width: 150),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
              ),
              Text(profession, style: TextStyle(fontSize: 12), textAlign: TextAlign.right),
              TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()),
                  ),
                  child: Text("Edit Profile"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}