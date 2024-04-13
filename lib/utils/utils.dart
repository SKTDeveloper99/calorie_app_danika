String getToday() {
  DateTime now = DateTime.now();

  // format to Day, Month Day
  String day = now.weekday.toString();
  switch (day) {
    case "1":
      day = "MONDAY";
      break;
    case "2":
      day = "TUESDAY";
      break;
    case "3":
      day = "WEDNESDAY";
      break;
    case "4":
      day = "THURSDAY";
      break;
    case "5":
      day = "FRIDAY";
      break;
    case "6":
      day = "SATURDAY";
      break;
    case "7":
      day = "SUNDAY";
      break;
  }

  // format to Month Day
  String month = now.month.toString();
  switch (month) {
    case "1":
      month = "JAN";
      break;
    case "2":
      month = "FEB";
      break;
    case "3":
      month = "MAR";
      break;
    case "4":
      month = "APR";
      break;
    case "5":
      month = "MAY";
      break;
    case "6":
      month = "JUN";
      break;
    case "7":
      month = "JUL";
      break;
    case "8":
      month = "AUG";
      break;
    case "9":
      month = "SEP";
      break;
    case "10":
      month = "OCT";
      break;
    case "11":
      month = "NOV";
      break;
    case "12":
      month = "DEC";
      break;
  }

  day = "$day, $month ${now.day}";

  return day;
}
