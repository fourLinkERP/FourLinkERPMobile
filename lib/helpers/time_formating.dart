

//to make the date in the form of date inside the api dd-mm-yyyy
String FN_prepareDate(String date)
{

  print('the date 000000: is $date');
  List<String> partsOfDate =date.split("-");

  String final_date=partsOfDate[0]+'-';
  if(partsOfDate[1].length!=2)
  {
    final_date = final_date+'0'+partsOfDate[1]+'-';
  }
  else
  { final_date = final_date+partsOfDate[1];}

  if(partsOfDate[2].length!=2)
  {
    final_date = final_date+'0'+partsOfDate[2];
  }
  else
  { final_date = final_date+partsOfDate[2];}

  return final_date;
}

String FN_prepareTime(String time) //convert from  PM  10:27  to     22:27
{
  String Zone =time.substring(0,2);
  String pure_time=time.substring(2).trim();
  String Pure_hour=pure_time.substring(0,pure_time.indexOf(":"));
  String Pure_mints=pure_time.substring(pure_time.indexOf(":"));

  if(Zone.contains('PM'))
    {
      print('pure_time $Pure_hour ${Pure_hour.length}');
      Pure_hour=(int.parse(Pure_hour)+12).toString();
    }

  return '$Pure_hour$Pure_mints';

}

String FN_changeToFormatPM(String time)// convert from 23:00 to 11:00 PM
{
  String result='';
  String Hour =time.substring(0,2);

  if(int.parse(Hour)<12)
    {
      result=time+' AM';
    }
  else
    {
      int hour =int.parse(Hour)-12;
       result=hour.toString()+time.substring(2)+' PM';
    }
 return  result ;
}


// add period to calculate expired date from start date
String FN_getExpiredDate(String startdate,String type)
{

  int days=0;

  if(type=='daily_price')
  {
    days=0;
  }
  else if(type=='weakly_price')
  {
    days=7;
  }
  else if(type=='monthly_price')
  {
    days=31;
  }
  else if(type=='quarter_yearly_price')
  {
    days=92;
  }
  else if(type=='half_yearly_price')
  {
    days=184;
  }
  else if(type=='yearly_price')
  {
    days=256;
  }



  startdate=FN_prepareDate(startdate);

  print('before is $startdate');
  DateTime parsedDate = DateTime.parse('$startdate 00:00:00.000');
  parsedDate=parsedDate.add(Duration(days: days,));

  String expiredDate =  parsedDate.year.toString()+'-'+
      parsedDate.month.toString()+'-'+
      parsedDate.day.toString();


  print('after is $expiredDate');


  return expiredDate;
}


String FN_getDay(String date)
{
 //return DateFormat('EEEE').format(DateTime.parse(date));

  return "";
}


String FN_increaseTime (String start_time)//to increase hours only one hour
{

 int hours =  int.parse(start_time.substring(0,start_time.indexOf(':')));

 return ('${(hours+1).toString()}${start_time.substring(start_time.indexOf(':'))}');
}


String FN_DiffDates(String dateProduct)
{
  print('the date 000000: is $dateProduct');
  List<String> partsOfDate =dateProduct.split("-");

  final birthday = DateTime(int.parse(partsOfDate[0]), int.parse(partsOfDate[1]), int.parse(partsOfDate[2].substring(0,2)));
  final date2 = DateTime.now();
  final difference = date2.difference(birthday).inDays;

  print('diff is $difference');
  return difference.toString();
}

String FN_prepareDateASList(String date)
{

  print('the date 000000: is $date');
  List<String> partsOfDate =date.split("-");

  String final_date=partsOfDate[0]+'-';
  if(partsOfDate[1].length!=2)
  {
    final_date = final_date+'0'+partsOfDate[1]+'-';
  }
  else
  { final_date = final_date+partsOfDate[1];}

  if(partsOfDate[2].length!=2)
  {
    final_date = final_date+'0'+partsOfDate[2];
  }
  else
  { final_date = final_date+partsOfDate[2];}

  return final_date;
}

String FN_calculateDays()
{
  var startdate = new DateTime.now().toString();
  int days=14;


  print('before is $startdate');
  DateTime parsedDate = DateTime.parse(startdate);
  parsedDate=parsedDate.add(Duration(days: days,));

  String expiredDate =  parsedDate.year.toString()+'-'+
      parsedDate.month.toString()+'-'+
      parsedDate.day.toString();


  print('after is $expiredDate');


  return expiredDate;
}
