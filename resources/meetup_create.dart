// class MeetupFormData {
//   String location = '';
//   String title = '';
//   String startDate = '';
//   Category category = null;
//   String image = '';
//   String shortInfo = '';
//   String description = '';
//   String timeTo = '';
//   String timeFrom = '';

//   Map<String, dynamic> toJSON() =>
//     {
//       'location': location,
//       'title': title,
//       'startDate': startDate,
//       'category': category,
//       'image': image,
//       'shortInfo': shortInfo,
//       'description': description,
//       'timeTo': timeTo,
//       'timeFrom': timeFrom
//     };
// }



// class MeetupCreateScreen extends StatefulWidget {

//   MeetupCreateScreenState createState() => MeetupCreateScreenState();
// }

// class MeetupCreateScreenState extends State<MeetupCreateScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   BuildContext _scaffoldContext;

//   MeetupFormData _meetupFormData = MeetupFormData();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Meetup')
//       ),
//       body: Builder(
//         builder: (context) {
//           _scaffoldContext = context;
//           return Padding(
//             padding: EdgeInsets.all(20.0),
//             child: _buildForm()
//           );
//         }
//       )
//     );
//   }

//   void handleSuccesfulCreate(dynamic data) async {
//     // await Navigator
//     //   .pushNamed(context, "/login",
//     //              arguments: LoginScreenArguments('You have been succesfuly logged in!'));
//   }

//   void handleError(String message) {
//     Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
//       content: Text(message)
//     ));
//   }

//   void _submitCreate() {
//     final form = _formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       print(_meetupFormData.toJSON());
//     }
//   }

//   Widget _buildForm() {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         children: [
//           _buildTitle(),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Location',
//             ),
//             onSaved: (value) => _meetupFormData.location = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Title',
//             ),
//             onSaved: (value) => _meetupFormData.title = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Start Date',
//             ),
//             onSaved: (value) => _meetupFormData.startDate = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Category',
//             ),
//             onSaved: (value) => _meetupFormData.category = null,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Image',
//             ),
//             onSaved: (value) => _meetupFormData.image = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(100)],
//             decoration: InputDecoration(
//               hintText: 'Short Info',
//             ),
//             onSaved: (value) => _meetupFormData.shortInfo = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(200)],
//             decoration: InputDecoration(
//               hintText: 'Description',
//             ),
//             onSaved: (value) => _meetupFormData.description = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Time From',
//             ),
//             onSaved: (value) => _meetupFormData.timeFrom = value,
//           ),
//           TextFormField(
//             style: Theme.of(context).textTheme.headline,
//             inputFormatters: [LengthLimitingTextInputFormatter(30)],
//             decoration: InputDecoration(
//               hintText: 'Time To',
//             ),
//             onSaved: (value) => _meetupFormData.timeTo = value,
//           ),
//           _buildSubmitBtn()
//         ],
//       ),
//     );
//   }

//   Widget _buildTitle() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 15.0),
//       child: Text(
//         'Register Today',
//         style: TextStyle(
//           fontSize: 30.0,
//           fontWeight: FontWeight.bold
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmitBtn() {
//     return Container(
//       alignment: Alignment(-1.0, 0.0),
//       child: RaisedButton(
//         textColor: Colors.white,
//         color: Theme.of(context).primaryColor,
//         child: const Text('Submit'),
//         onPressed: _submitCreate,
//       )
//     );
//   }
// }

