

List<String> generateTimes({int interval = 30}) {
  List<String> times = [];
  int tt = 0;

  for (var i=0; tt<24 * 60; i++) {
    var hh = tt ~/ 60; // getting hours of day in 0-24 format
    var mm = tt % 60; // getting minutes of the hour in 0-55 format

    var hhS = ("0" + (hh >= 12 ? (hh % 24).toString() : (hh % 12).toString()));
    var hhSf = hhS.substring(hhS.length - 2);

    var mmS = ("0" + mm.toString());
    var mmSf = mmS.substring(mmS.length - 2);

    times.add(hhSf + ':' + mmSf);

    tt += interval;
  }
  times.add('23:59');
  return times;
}
