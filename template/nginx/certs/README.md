# SSL certificates used by web container

If certificates are not found, they are automaticaly generated using `DOMAINS` env variable.
If `DOMAINS` is empty, then no certificate files are created or modified.

Automatically generated certificates are set to be valid for 50 years.

`docky-root.crt` (public) should be imported into browser and added to cacert.pem file that client is using.
Windows client may use Windows own certificate store, so `docky-root.crt` should be imported there.

`"Trust this for identifying websites"` (or similar) checkbox needs to be enabled for `Docky Root CA` authority.

Root certificate authority
* docky-root.key (private)
* docky-root.crt (public)

Certificate issuer
* docky-issuer.key (private)
* docky-issuer.crt (public)

Web server
* server.key (private)
* server.crt (public)
* server.pem (server.crt + docky-issuer.crt)

