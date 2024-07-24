## making short-lived credential.

 - in case of gcloud available

```
for /f %i in ('gcloud auth print-access-token --impersonate-service-account YOUR_SERVICE_ACCOUNT_MAIL') do set GOOGLE_OAUTH_ACCESS_TOKEN=%i
```

for /f %i in ('gcloud auth print-access-token --impersonate-service-account sa-terreform-core@terraform-in-gcp-429414.iam.gserviceaccount.com') do set GOOGLE_OAUTH_ACCESS_TOKEN=%i