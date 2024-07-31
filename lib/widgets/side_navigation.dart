import 'package:flutter/material.dart';

Widget DrawerClass(dynamic context) {
  return Container(
    child: Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // padding: EdgeInsets.all(0),
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  trailing: Container(
                    width: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text("4.90"),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wallet),
                  title: Text('Wallet'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book_online_outlined),
                  title: Text('My orders'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.airplane_ticket_sharp),
                  title: Text('Promo'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('App feedback'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /* ListTile(
                  leading: Icon(Icons.drive_eta_rounded),
                  title: Text('Become a driver'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ), */
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Icon(Icons.drive_eta_rounded)),
                    Text("Become a driver")
                  ],
                ),
                Container(
                  width: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    textAlign: TextAlign.center,
                    "New",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
