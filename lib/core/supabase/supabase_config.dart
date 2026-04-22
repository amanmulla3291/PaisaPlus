import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  SupabaseConfig._(); // prevent instantiation

  /// Your Supabase project URL (Settings → API → Project URL)
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? 'YOUR_SUPABASE_URL';

  /// Your Supabase anon/public key (Settings → API → anon public)
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? 'YOUR_SUPABASE_ANON_KEY';

  /// Google Web Client ID for OAuth
  static String get googleWebClientId => dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? 'YOUR_GOOGLE_WEB_CLIENT_ID';
}
