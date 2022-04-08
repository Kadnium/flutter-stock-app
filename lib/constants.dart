import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const kBaseUrl = "";//"http://192.168.0.4:3000/api";
const kUseAuth = false;


bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
}



const Map<String,String> kIndexData = {
  "^GSPC":"S&P 500",
  "^DJI":"DOW 30",
  "^IXIC":"NASDAQ",
  "^RUT":"Russell 2000",
  "CL=F":"Oil",
  "GC=F":"Gold",
  "SI=F":"Silver",
  "EURUSD=X":"EUR/USD",
  "^TNX":"10-Yr Bond",
  "GBPUSD=X":"GBP/USD",
  "JPY=X":"USD/JPY",
  "BTC-USD":"Bitcoin",
  "^CMC200":"CMC Crypto",
  "^FTSE":"FTSE 100",
  "^N225":"Nikkei 225"
  };