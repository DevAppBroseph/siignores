
String convertIntToStringTime(int hour, int minute, int second){
  String res = '';
  if(hour > 0){
    res += '$hour:';
  }
  if(minute >= 10){
    res += '$minute:';
  }else{
    res += '0$minute:';
  }
  if(second >= 10){
    res += '$second';
  }else{
    res += '0$second';
  }
  return res;
}