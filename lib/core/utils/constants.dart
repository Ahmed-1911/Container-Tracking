import '../../data/entity/company.dart';

class Constants {
  static const token = "Token";
  static const languageCode = "language_code";
  static const countryCode = "countryCode";
  static const alarmDate = "alarmDate";
  static const companyName = "companyName";
  static const portAccess = "portAccess";
  static const containerNumber = "containerNumber";
  static const alarmDescription = "alarmDescription";
  static const appId = '4';

  static List<Company> companiesList = [
    Company(
      image: 'assets/images/maersk.png',
      url: 'https://www.maersk.com/tracking/',
    ),
    Company(
      image: 'assets/images/cosco.png',
      url: 'https://elines.coscoshipping.com/ebusiness/cargotracking',
    ),
    Company(
      image: 'assets/images/cma.png',
      url: 'https://www.cma-cgm.com/ebusiness/tracking',
    ),
    Company(
      image: 'assets/images/hmm.png',
      url: 'https://www.hmm21.com/cms/company/engn/index.jsp',
    ),
    Company(
      image: 'assets/images/apl.png',
      url: 'https://www.apl.com/ebusiness/tracking',
    ),
    Company(
      image: 'assets/images/hapag.png',
      url:
          'https://www.hapag-lloyd.com/en/online-business/track/track-by-container-solution.html',
    ),
    Company(
      image: 'assets/images/msc.png',
      url: 'https://www.msc.com/en/track-a-shipment',
    ),
    Company(
      image: 'assets/images/pil.png',
      url:
          'https://www.pilship.com/en-our-track-and-trace-pil-pacific-international-lines/120.html',
    ),
    Company(
      image: 'assets/images/evergreen.png',
      url: 'https://ct.shipmentlink.com/servlet/TDB1_CargoTracking.do',
    ),
    Company(
      image: 'assets/images/yang.png',
      url:
          'https://www.yangming.com/e-service/track_trace/track_trace_cargo_tracking.aspx',
    ),
    Company(
      image: 'assets/images/one.png',
      url: 'https://ecomm.one-line.com/one-ecom/manage-shipment/cargo-tracking',
    ),
    Company(
      image: 'assets/images/oocl.png',
      url:
          'https://www.oocl.com/eng/ourservices/eservices/cargotracking/Pages/cargotracking.aspx',
    ),
  ];
}
