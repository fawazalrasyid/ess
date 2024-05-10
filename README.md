# ESS - EarthStock Solution

Sistem yang terintegrasi dengan aplikasi seluler dan situs web, dirancang untuk membantu pengguna dalam melakukan prediksi stok karbon di berbagai lokasi. Sistem ini memanfaatkan Google Earth Engine dan teknologi Machine Learning VGG16 untuk menyajikan perkiraan yang akurat. Dengan kemampuan ini, pengguna dapat dengan mudah mengakses informasi mengenai kandungan karbon di berbagai wilayah melalui antarmuka yang ramah pengguna, yang mencakup data visual dari Google Earth Engine serta analisis dalam skala besar dari model Machine Learning VGG16.

## Getting Started

All that you need is flutter installation, see here: https://docs.flutter.dev/

## Prerequisites

There are several things that you need to do to run this project perfectly:

- Prepare you Google Maps API with this following API service enabled : `Geocoding API, Geolocation API,
Maps SDK for Android, Maps SDK for iOS, Places API`. [See More](https://developers.google.com/maps/apis-by-platform)
- prepare you favorite code editor (Android Studio, Visual Studio Code)
- phone emulator

## Installation

1. cloning this project
2. rename `constants.example` to `constants.dart`
3. rename `AndroidManifest.example` to `AndroidManifest.xml`
4. rename `AppDelegate.example` to `AppDelegate.swift`
5. fill `constants.dart` with this following value:

```
static const GOOGLE_MAPS_API_KEY = 'Fill with your Google Maps API Key';
```

6. fill `AndroidManifest.xml` with this following value:

```
<meta-data android:name="com.google.android.geo.API_KEY"
    android:value="Fill with your Google Maps API Key"/>
```

7. fill `AppDelegate.swift` with this following value:

```
GMSServices.provideAPIKey("Fill with your Google Maps API Key")
```

8. `flutter pub get`
9. run

## Deployment

to build this project to .apk run `flutter build apk`

# Documentation

1. install file apk yang sudah di sediakan
2. login dengan akun testing

```
email: test@gmail.com
password: test123
```

atau register dan lakukan verifikasi email.

3. aktifkan permission `lokasi`

4. Nikmati pengalaman menggunakan ESS.

## NOTES

Link Machine Learning :
https://github.com/satriadhm/ess-ml

## APK

klik link ini untuk mendapatkan file apk: [klik disini.](https://drive.google.com/file/d/1Kwu4SGAfj4GUdIDdS940h8mNrotx354j/view?usp=sharing)

## Authors

- **Fawaz Al Rasyid** - _From SYNK Team_ for Find-IT
