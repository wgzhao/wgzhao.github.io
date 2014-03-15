# ./kolab_bootstrap -b

KOLAB BOOTSTRAP

Check for running webserver on port 80
Check for running webserver on port 443
Check for running imap server on port 143
Check for running imap server on port 220
Check for running imap server on port 585
Check for running imap server on port 993
Check for running pop3 server on port 109
Check for running pop3 server on port 110
Check for running pop3 server on port 473
Check for running pop3 server on port 995
Check for running smtp server on port 25
Check for running smtp server on port 465
Check for running ftp server on port 21
Check for running Amavis Virus Scanner Interface on port 10024
Check for running Kolab daemon on port 9999
Check for running OpenLDAP server on port 636
Check for running OpenLDAP server on port 389
Check for running Sieve server on port 2000
Excellent all required Ports are available!
LDAP repository is empty - assuming fresh install
Please enter Hostname including Domain Name (e.g. thishost.domain.tld) [kolab2demo]: kolab2demo.redflag.com
Proceeding with Hostname kolab2demo.redflag.com
Do you want to set up (1) a master Kolab server or (2) a slave [1] (1/2): 1
Proceeding with master server setup

Please enter your Maildomain - if you do not know your mail domain use the fqdn from above [redflag.com]:
proceeding with Maildomain redflag.com
Kolab primary email addresses will be of the type user@redflag.com
Generating default configuration:
 base_dn : dc=redflag,dc=com
 bind_dn : cn=manager,cn=internal,dc=redflag,dc=com
Please choose a manager password [tpX3h5jMMeCMCiT6]: abc123
 bind_pw : abc123
done modifying /kolab/etc/kolab/kolab.conf

IMPORTANT NOTE:
use login=manager and passwd=abc123 when you log into the webinterface!

Enter fully qualified hostname of slave kolab server e.g. thishost.domain.tld [empty when done]:    
prepare LDAP database...
temporarily starting slapd
Waiting for OpenLDAP to start
no dc=redflag,dc=com object found, creating one
mynetworkinterfaces: 127.0.0.0/8
LDAP setup finished

Create initial config files for postfix, apache, proftpd, cyrus imap, saslauthd
running /kolab/sbin/kolabconf -n
kolabconf - Kolab Configuration Generator

  Version: 2.0.3

  Copyright (c) 2004  Klaraelvdalens Datakonsult AB
  Copyright (c) 2003  Code Fusion cc
  Copyright (c) 2003  Tassilo Erlewein, Martin Konold, Achim Frank, erfrakon

This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

kill temporary slapd

OpenPKG: stop: openldap.
Creating RSA keypair for resource password encryption
/kolab/bin/openssl genrsa -out /kolab/etc/kolab/res_priv.pem 1024
Generating RSA private key, 1024 bit long modulus
..............++++++
.........................................................++++++
e is 65537 (0x10001)
/kolab/bin/openssl rsa -in /kolab/etc/kolab/res_priv.pem -pubout -out /kolab/etc/kolab/res_pub.pem
writing RSA key
chown kolab:kolab-n /kolab/etc/kolab/res_pub.pem /kolab/etc/kolab/res_priv.pem
Kolab can create and manage a certificate authority that can be
used to create SSL certificates for use within the Kolab environment.
You can choose to skip this section if you already have certificates
for the Kolab server.
Do you want to create CA and certificates [y] (y/n): y
Now we need to create a cerificate authority (CA) for Kolab and a server
certificate. You will be prompted for a passphrase for the CA.
################################################################################
/kolab/etc/kolab/kolab_ca.sh -newca kolab2demo.redflag.com
Enter organization name [Kolab]: redflag
Enter organizational unit [Test-CA]: support
Using subject O=redflag,OU=support,CN=kolab2demo.redflag.com
Using dn
CA certificate filename (or enter to create)

Making CA certificate ...
Generating a 1024 bit RSA private key
....................++++++
....++++++
writing new private key to '/kolab/etc/kolab/ca/private/cakey.pem'
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
-----
/kolab/etc/kolab
/kolab/etc/kolab/kolab_ca.sh -newkey kolab2demo.redflag.com /kolab/etc/kolab/key.pem
Using dn
Generating RSA private key, 1024 bit long modulus
.......................................++++++
....++++++
e is 65537 (0x10001)
writing RSA key
/kolab/etc/kolab
/kolab/etc/kolab/kolab_ca.sh -newreq kolab2demo.redflag.com /kolab/etc/kolab/key.pem /kolab/etc/kolab/newreq.pem
Using dn
Request is in /kolab/etc/kolab/newreq.pem and private key is in /kolab/etc/kolab/key.pem
/kolab/etc/kolab
/kolab/etc/kolab/kolab_ca.sh -sign /kolab/etc/kolab/newreq.pem /kolab/etc/kolab/cert.pem
Using dn
Using configuration from /kolab/etc/kolab/kolab-ssl.cnf
Enter pass phrase for /kolab/etc/kolab/ca/private/cakey.pem:
16429:error:28069065:lib(40):UI_set_result:result too small:ui_lib.c:847:You must type in 4 to 8191 characters
Enter pass phrase for /kolab/etc/kolab/ca/private/cakey.pem:
16429:error:28069065:lib(40):UI_set_result:result too small:ui_lib.c:847:You must type in 4 to 8191 characters
Enter pass phrase for /kolab/etc/kolab/ca/private/cakey.pem:
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number: 1 (0x1)
        Validity
            Not Before: Jul 14 05:08:09 2006 GMT
            Not After : Jul 11 05:08:09 2016 GMT
        Subject:
            commonName                = kolab2demo.redflag.com
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                F2:98:64:F6:F5:AF:C9:51:80:85:6C:F5:74:C3:97:BE:E0:48:A5:FC
            X509v3 Authority Key Identifier:
                DirName:/O=redflag/OU=support/CN=kolab2demo.redflag.com
                serial:E7:89:CF:0A:5E:A6:59:B9

Certificate is to be certified until Jul 11 05:08:09 2016 GMT (3650 days)
1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
Signed certificate is in /kolab/etc/kolab/cert.pem
/kolab/etc/kolab
chgrp kolab-r /kolab/etc/kolab/key.pem;
chmod 0640 /kolab/etc/kolab/key.pem;
chgrp kolab-r /kolab/etc/kolab/cert.pem;
chmod 0640 /kolab/etc/kolab/cert.pem;
################################################################################
CA and certificate creation complete.

You can install /kolab/etc/kolab/ca/cacert.pem on your clients to allow them
to verify the validity of your server certificates.

kolab is now ready to run!
please run /kolab/bin/openpkg rc all start;
Use login=manager and passwd=abc123 when you log into
the webinterface https://kolab2demo.redflag.com/admin !
