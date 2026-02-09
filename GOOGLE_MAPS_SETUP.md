# Google Maps API Setup Guide

This guide will help you set up Google Maps API for the Bunyan app project details screen.

## App Package Information

- **Android Package Name:** `com.example.bunyanapp`
- **iOS Bundle ID:** `com.example.bunyanapp`

## Step 1: Get Your Google Maps API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - **Maps SDK for Android**
   - **Maps SDK for iOS**
4. Navigate to **APIs & Services** → **Credentials**
5. Click **Create Credentials** → **API Key**
6. Copy your API key

## Step 2: Restrict Your API Key (IMPORTANT for Security)

### For Android:

1. Click on your API key in the Credentials page
2. Under **Application restrictions**, select **Android apps**
3. Click **Add an item**
4. Enter:
   - **Package name:** `com.example.bunyanapp`
   - **SHA-1 certificate fingerprint:** Get this by running:
     ```bash
     # For debug keystore (default location)
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     
     # For release keystore (if you have one)
     keytool -list -v -keystore <path-to-your-release-keystore> -alias <your-key-alias>
     ```
5. Copy the SHA-1 fingerprint (looks like: `AA:BB:CC:DD:EE:FF:...`)
6. Paste it in the **SHA-1 certificate fingerprint** field
7. Click **Save**

### For iOS:

1. Under **Application restrictions**, select **iOS apps**
2. Click **Add an item**
3. Enter:
   - **Bundle ID:** `com.example.bunyanapp`
4. Click **Save**

### API Restrictions:

1. Under **API restrictions**, select **Restrict key**
2. Select:
   - ✅ Maps SDK for Android
   - ✅ Maps SDK for iOS
3. Click **Save**

## Step 3: Enable Billing

⚠️ **Important:** Google Maps requires billing to be enabled, but offers a free tier:

1. Go to **Billing** in Google Cloud Console
2. Link a billing account (credit card required)
3. **Free Tier:** $200 credit per month (covers ~28,000 map loads)
4. Monitor usage in the **APIs & Services** → **Dashboard**

## Step 4: Add API Key to Your App

### Android Configuration

Edit `android/app/src/main/AndroidManifest.xml`:

Replace `YOUR_GOOGLE_MAPS_API_KEY` with your actual API key:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ACTUAL_API_KEY_HERE" />
```

### iOS Configuration

Edit `ios/Runner/Info.plist`:

Replace `YOUR_GOOGLE_MAPS_API_KEY` with your actual API key:

```xml
<key>GMSApiKey</key>
<string>YOUR_ACTUAL_API_KEY_HERE</string>
```

## Step 5: Install Dependencies

Run in your terminal:

```bash
flutter pub get
```

## Step 6: Test the Map

1. Run your app: `flutter run`
2. Navigate to a project details screen
3. The map should display:
   - Real Google Maps with the location from `mapLocation` field
   - Custom pin overlay with building image from `projectImagePath`
   - Zoom level set to 15
   - Gestures disabled (static preview)

## Troubleshooting

### Map shows blank/grey screen:
- ✅ Verify API key is correct in both AndroidManifest.xml and Info.plist
- ✅ Check that Maps SDK for Android/iOS APIs are enabled
- ✅ Verify billing is enabled
- ✅ Check API key restrictions match your package name/bundle ID
- ✅ For Android: Ensure SHA-1 fingerprint is correct

### "API key not valid" error:
- ✅ Verify the API key is copied correctly (no extra spaces)
- ✅ Check API restrictions allow Maps SDK for Android/iOS
- ✅ Ensure application restrictions match your package/bundle ID

### Map doesn't show custom pin:
- ✅ Verify `projectImagePath` is set correctly in ProjectDetailsModel
- ✅ Check that the image asset exists in `assets/images/projects/`
- ✅ Ensure image is listed in `pubspec.yaml` assets section

## Security Best Practices

1. ✅ **Always restrict your API key** to your app's package name/bundle ID
2. ✅ **Add SHA-1 fingerprint** for Android (required for release builds)
3. ✅ **Restrict APIs** to only Maps SDK for Android/iOS
4. ✅ **Monitor usage** in Google Cloud Console to detect abuse
5. ✅ **Set up billing alerts** to avoid unexpected charges
6. ✅ **Never commit API keys** to public repositories (use environment variables for CI/CD)

## Current Implementation Details

- **Map Type:** Normal (standard Google Maps view)
- **Zoom Level:** 15.0 (street level)
- **Gestures:** All disabled (static preview)
- **Custom Pin:** Orange circular pin with building image inside
- **Location Format:** "lat,lng" (e.g., "24.7136,46.6753")
- **Default Location:** Riyadh, Saudi Arabia (24.7136, 46.6753)

## Support

For Google Maps API issues, refer to:
- [Google Maps Platform Documentation](https://developers.google.com/maps/documentation)
- [Flutter Google Maps Plugin](https://pub.dev/packages/google_maps_flutter)
