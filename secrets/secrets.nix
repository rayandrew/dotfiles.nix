let
  # users
  macbook18User = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFtFdJybv0ZkO1p/8WmBVMRLIoaK/EIrK0gtjxBOLUU4eJxDpM2LLkDHJCscsMuSwPf5zfo19L7ofbX5lJ2JE2Nux4etoFoyh/dJTrDrrhBfqEwIaGblwvgs1spCfVp+zozQR5/dE1LTSj1Rrs2bbwskHntVpsWJqHnNhZ+MCjDy4EyS8VMVv6RZlPxU2abH2mO+np06pMDd7eeRG5o01JKFZkUwwNAHF4nLboaajHv/rduzWe4WHd4wRAfaGVvfZOHeaSXZUeEaYj2TOGzNZCy1lifqUVAvKb5jvu+PZwMtEliu7Ph3bbGLO+I++LCKDyfoMb557zUOSgUoxHQEX7yD99f0xQtGsp9QXjTyaBUOlqSlKsZ7g2PJ4OXVbzAMqtVT4My7JLJS+aQzAnoZN3Y6pf+xYr74xvF8ooBMP8veXgZB4fsP+uTHUkDfyaxZgtF3nuC55J4YrTzDejrUPLPdXl8JcR86d65Z8K4Sx9Dn68wy+qwGeARMgnqhpW5t6ql361esEYp+OgVI9GjQiV7G/SbPSwEzLNfqcUOcnjJvyCR4aglwNYAzk4nGnHI9oGUsV2Ph1614XPk/HmN1rfn6Mhd/a43eqe2Ahh1Q8WTO36JUvnZSepJx+24uFHhkY6ovI50xew70V4KF51kCMrspqktquVouqfafKq39yJIw==";
  lemurUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHXcQ1TjEjFP3/u7w0qPerdEd4oV0nyCfRUJV10XVcQH";
  omenUser = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0xh+6ZkORm10teBN5P+rxKvb7xUVTtGBlLltyyBRRKHLmJkNHTxTOhhAewshjGMNXUoiMpRsgcpDET3F3mH24qGLGBXus24mseWCeW7wJxa/gLvA9QIVD/Ml1+p+OJiu9B+JAJO+YvRygloteIQ6K5MqiS1B4Sve9mq7H6eezyiy/43cj59YKYvIR2et2IOJJCT3oFf/Swb1vqLe1pZBHYNxOXTTkJXynUwihjcgkVBJszVj2uiUlGdxxG8vFwwqd+wLIQNCg7y6yU+dUrbh6uuM3Fu92oQtV03qx19i14E6pr+s/L7brUnG86j9cBUsxynt3YTy0DxJD7QndeqVQJXKLlAFC8MetP6lFMxidg58ZLuOOJeOgL9RblJRePwtmlRx/apqvgOyCYKZ7ElRiQJWbTrY5ZD/OWi47gSK6rZrEXnkPKDyaLdbtN08T3AlUd+FXvG4hwfyODpGX4033j7+bG05IVk3NiUuvLM7KucGWVea7+ra2wsf1u7STf1xHi+mx56NvXOI20KmrojIJ45HCLTjrn47v78GXAnjcapnWszEebCNcW6hj6qQS4vScr045tGW17fIseclUm2LtfhRRnFO9K2CWvoGAZGjSbaJTF3tQwfJU21wjW6Y0vSkqibZDHX5GRu6pmsftadFu+6sGUrGLYacamETXNuoZEQ==";
  users = [ macbook18User lemurUser omenUser ];

  # hosts 
  lemurHost = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoNXOnOotJ0es+dVxk0+a9TvVEX4ONQ5g2gD57tcpx8";

  hosts = [ lemurHost ];

  allKeys = users ++ hosts;
in
{
  # user
  "root-pw.age".publicKeys = allKeys;
  "user-pw.age".publicKeys = allKeys;

  # spotify
  "spotify-id.age".publicKeys = allKeys;
  "spotify-secret.age".publicKeys = allKeys;
}
