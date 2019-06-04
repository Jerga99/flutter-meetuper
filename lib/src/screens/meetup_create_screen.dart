import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meetuper/src/models/category.dart';
import 'package:flutter_meetuper/src/models/forms.dart';
import 'package:flutter_meetuper/src/screens/meetup_detail_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_home_screen.dart';
import 'package:flutter_meetuper/src/services/meetup_api_service.dart';
import 'package:flutter_meetuper/src/utils/generate_times.dart';
import 'package:flutter_meetuper/src/widgets/select_input.dart';
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
  final List<String> _times = generateTimes();

  @override
  initState() {
    _api.fetchCategories()
      .then((categories) => setState(() => _categories = categories));

    super.initState();
  }

  _handleDateChange(DateTime selectedDate) {
    _meetupFormData.startDate = selectedDate;
  }

  void _submitCreate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _api.createMeetup(_meetupFormData)
        .then((String meetupId) {
          Navigator
            .pushNamedAndRemoveUntil(
              context,
              MeetupDetailScreen.route,
              ModalRoute.withName('/'),
              arguments: MeetupDetailArguments(id: meetupId));
        })
        .catchError((e) => print(e));
    }
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
          _DatePicker(onDateChange: _handleDateChange),
          SelectInput<Category>(
            items: _categories,
            onChange: (Category c) => _meetupFormData.category = c,
            label: 'Category'
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headline,
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
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onSaved: (value) => _meetupFormData.description = value,
          ),
          SelectInput<String>(
            items: _times,
            onChange: (String t) => _meetupFormData.timeFrom = t,
            label: 'Time From'
          ),
          SelectInput<String>(
            items: _times,
            onChange: (String t) => _meetupFormData.timeTo = t,
            label: 'Time To'
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

class _DatePicker extends StatefulWidget {
  final Function(DateTime date) onDateChange;

  _DatePicker({@required this.onDateChange});

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
    if (picked != null && picked != _initialDate) {
        widget.onDateChange(picked);
        setState(() {
          _dateController.text = _dateFormat.format(picked);
          _initialDate = picked;
        }
      );
    }
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

