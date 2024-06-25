# Keep rules for Google Play Services Credentials API
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-keep class com.google.android.gms.auth.api.credentials.Credential$Builder { *; }
-keep class com.google.android.gms.auth.api.credentials.Credential { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialPickerConfig$Builder { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialPickerConfig { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialRequest$Builder { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialRequest { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialRequestResponse { *; }
-keep class com.google.android.gms.auth.api.credentials.Credentials { *; }
-keep class com.google.android.gms.auth.api.credentials.CredentialsClient { *; }
-keep class com.google.android.gms.auth.api.credentials.HintRequest$Builder { *; }
-keep class com.google.android.gms.auth.api.credentials.HintRequest { *; }

# Suppress warnings for missing classes
-dontwarn com.google.android.gms.auth.api.credentials.Credential$Builder
-dontwarn com.google.android.gms.auth.api.credentials.Credential
-dontwarn com.google.android.gms.auth.api.credentials.CredentialPickerConfig$Builder
-dontwarn com.google.android.gms.auth.api.credentials.CredentialPickerConfig
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequest$Builder
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequest
-dontwarn com.google.android.gms.auth.api.credentials.CredentialRequestResponse
-dontwarn com.google.android.gms.auth.api.credentials.Credentials
-dontwarn com.google.android.gms.auth.api.credentials.CredentialsClient
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest$Builder
-dontwarn com.google.android.gms.auth.api.credentials.HintRequest

# Keep rules for SmartAuthPlugin
-keep class fman.ge.smart_auth.** { *; }
