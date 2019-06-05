// if (snapshot.hasData) {
//   final users = snapshot.data.joinedPeople;
//   if (users != null && users.length > 0) {
//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (context, i) {
//         final user = users[i];
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 30.0,
//                   backgroundImage: user.avatar.isNotEmpty  ? NetworkImage(user?.avatar) : null
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 10.0),
//                   child: Text(user.name, style: TextStyle(fontSize: 20.0, color: Colors.black87))
//                 )

//               ]
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// return Container(width: 0, height: 0);
