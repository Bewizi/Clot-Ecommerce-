import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseApi {
  static const String url = 'https://xoyivdjzatxyibxxongv.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhveWl2ZGp6YXR4eWlieHhvbmd2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2ODg3ODgsImV4cCI6MjA4OTI2NDc4OH0.COXLN1rrsJRR84wjIk_0wZcjdMjCgAhDnQ-ADXwrSzM';
}

final SupabaseClient supaBase = Supabase.instance.client;
