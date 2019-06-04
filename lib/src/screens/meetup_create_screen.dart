import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meetuper/src/models/category.dart';
import 'package:flutter_meetuper/src/models/forms.dart';
import 'package:flutter_meetuper/src/services/meetup_api_service.dart';
import 'package:intl/intl.dart';

class MeetupCreateScreen extends StatefulWidget {
  static final String route = '/meetupCreate';

  MeetupCreateScreenState createState() => MeetupCreateScreenState();
}

class MeetupCreateScreenState extends State<MeetupCreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext _scaffoldContext;
  MeetupFormData _meetupFormData = MeetupFormData();
  MeetupApiService _api = MeetupApiService();
  List<Category> _categories = [];

  @override
  initState() {
    _api.fetchCategories()
      .then((categories) => setState(() => _categories = categories));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meetup')
      ),
      body: Builder(
        builder: (context) {
          _scaffoldContext = context;
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: _buildForm()
          );
        }
      )
    );
  }

  void handleSuccesfulCreate(dynamic data) async {
    // await Navigator
    //   .pushNamed(context, "/login",
    //              arguments: LoginScreenArguments('You have been succesfuly logged in!'));
  }

  void handleError(String message) {
    Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
      content: Text(message)
    ));
  }

  void _submitCreate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(_meetupFormData.toJSON());
      print(_meetupFormData.startDate);
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _buildTitle(),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              hintText: 'Location',
            ),
            onSaved: (value) => _meetupFormData.location = value,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              hintText: 'Title',
            ),
            onSaved: (value) => _meetupFormData.title = value,
          ),
          _DatePicker(),
          _CategorySelect(categories: _categories, meetupFormData: _meetupFormData),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              hintText: 'Image',
            ),
            onSaved: (value) => _meetupFormData.image = value,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: InputDecoration(
              hintText: 'Short Info',
            ),
            onSaved: (value) => _meetupFormData.shortInfo = value,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(200)],
            decoration: InputDecoration(
              hintText: 'Description',
            ),
            onSaved: (value) => _meetupFormData.description = value,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              hintText: 'Time From',
            ),
            onSaved: (value) => _meetupFormData.timeFrom = value,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              hintText: 'Time To',
            ),
            onSaved: (value) => _meetupFormData.timeTo = value,
          ),
          _buildSubmitBtn()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'Create Awesome Meetup',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      alignment: Alignment(-1.0, 0.0),
      child: RaisedButton(
        textColor: Colors.white,
        color: Theme.of(context).primaryColor,
        child: const Text('Submit'),
        onPressed: _submitCreate,
      )
    );
  }
}


class _CategorySelect extends StatelessWidget {
  final List<Category> categories;
  final MeetupFormData meetupFormData;

  _CategorySelect({@required this.categories,
                   @required this.meetupFormData});

  Widget build(BuildContext context) {
    return FormField<Category>(
      builder: (FormFieldState<Category> state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.color_lens),
            labelText: 'Category',
          ),
          isEmpty: meetupFormData.category == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Category>(
              value: meetupFormData.category,
              isDense: true,
              onChanged: (Category newCategory) {
                meetupFormData.category = newCategory;
                state.didChange(newCategory);
              },
              items: categories.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}


class _DatePicker extends StatefulWidget {
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<_DatePicker> {
  DateTime _dateNow = DateTime.now();
  DateTime _initialDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _initialDate,
        firstDate: _dateNow,
        lastDate: DateTime(_dateNow.year + 1, _dateNow.month, _dateNow.day));
    if (picked != null && picked != _initialDate)
      setState(() {
        _dateController.text = _dateFormat.format(picked);
        _initialDate = picked;
      }
    );
  }

  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new TextFormField(
        enabled: false,
        decoration: new InputDecoration(
          icon: const Icon(Icons.calendar_today),
          hintText: 'Enter date when meetup starts',
          labelText: 'Dob',
        ),
        controller: _dateController,
        keyboardType: TextInputType.datetime,
      )),
      IconButton(
        icon: new Icon(Icons.more_horiz),
        tooltip: 'Choose date',
        onPressed: (() {
          _selectDate(context);
        }),
      )
    ]);
  }
}

