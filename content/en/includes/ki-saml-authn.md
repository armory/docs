
#### SAML Authentication

Trying to login to Spinnaker using a SAML provider shows an error like the following:

```
{"timestamp":1597865813098,"status":500,"error":"Internal Server Error","message":"Error creating output document"}
```

This is caused by a version dependency bump in owasp esapi.
No workaround exists.

**Affected versions**: 2.21.1, 2.21.0

**Fixed versions**: 2.21.2
