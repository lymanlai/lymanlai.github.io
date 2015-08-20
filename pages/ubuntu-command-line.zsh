############################################
#
# After starting up Ubuntu VPS, we need to
# install and edit a few things.
#
############################################

                ***

############################################

# ADD NEW USER:

$ useradd example-user

# ADD PASSWORD FOR NEW USER:

$ passwd example-user

############################################
# ADD USER TO 'SUDO' GROUP:

# In the terminal:

$ visudo

# Add one line after root user section:
############################################
# User privilege specification
root    ALL=(ALL:ALL) ALL
# Add your user to sudo group:
example-user   ALL=(ALL:ALL) ALL

############################################
# Here is visudo file full example:

Defaults        env_reset
Defaults        mail_badpass
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root    ALL=(ALL:ALL) ALL
example-user   ALL=(ALL:ALL) ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d
############################################

                 ***

############################################

# UPGRADE YOUR UBUNTU TO THE LATEST VERSION:
# login yourself as a root user:

$ su -

# and begin upgrade process:
$ apt-get update && apt-get install update-manager-core && apt-get upgrade &&
do-release-upgrade -d

############################################
# Read and follow all instructions with attention,
# when it is prompted reboot & restart your ssh connection
############################################

                ***

############################################
# FIRST THINGS FIRST:
############################################

# Install MYSQL database and php5 addon for mysql:

$ sudo apt-get install mysql-server php5-mysql
$ sudo mysql_install_db
$ sudo /usr/bin/mysql_secure_installation

# Install and start NGINX:
$ sudo apt-get install nginx
$ sudo service nginx start

# To check your IP address - use this command:
$ ifconfig eth0 | grep inet | awk '{ print $2 }'

# Install PHP5 for wordpress setup:
$ sudo apt-get install php5-fpm php-pear php5-dev

############################################
# Edit files:
############################################

$ sudo nano /etc/php5/fpm/php.ini

#
    ;;;;;;;;;;;;;;;;;
    ; Data Handling ;
    ;;;;;;;;;;;;;;;;;
    ; Maximum size of POST data that PHP will accept.
    ; Its value may be 0 to disable the limit. It is ignored if POST data reading
    ; is disabled through enable_post_data_reading.
    ; http://php.net/post-max-size
    post_max_size = 8M

    ;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Paths and Directories ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;
    ; cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
    ; previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
    ; what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
    ; this to 1 will cause PHP CGI to fix its paths to conform to the spec.  A setting
    ; of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
    ; to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
    ; http://php.net/cgi.fix-pathinfo
    cgi.fix_pathinfo=0

    ;;;;;;;;;;;;;;;;
    ; File Uploads ;
    ;;;;;;;;;;;;;;;;

    ; Whether to allow HTTP file uploads.
    ; http://php.net/file-uploads
    file_uploads = On

    ; Maximum allowed size for uploaded files.
    ; http://php.net/upload-max-filesize
    ; add here as much as you want to:
    upload_max_filesize = 100M

    ; Maximum number of files that can be uploaded via a single request
    ; change defaults to the numbers you need:
    max_file_uploads = 50


--> Save & CLose

Next file:

############################################
# !! ATTENTION!!
# Change user from www-data to your user-name (example-user) to avoid
# all problems with uploading files, updatating wordpress or plugins,
# maintaining all frontend works in the future!
############################################

$ sudo nano /etc/php5/fpm/pool.d/www.conf

# And check/change (default is www-data) this lines:
    user = example-user
    group = www-data

    pm = dynamic
    pm.max_children = 5


--> Save & Close

############################################

# Reload php5-fpm configuration:

$ sudo service php5-fpm restart

############################################
# Prepare directories for websites:

$ sudo mkdir -p /var/www
$ sudo mkdir -p /var/www/example.com

############################################
# Check all required php variables by setting up info.php:

$ sudo nano /usr/share/nginx/html/info.php

# and insert following lines:

    <?php
     phpinfo();
    ?>

$ sudo service nginx restart

# Check example.com/info.php in your browser;
# and if everything is fine remove it (security):

$ sudo rm /usr/share/nginx/html/info.php

############################################

                ***

############################################
THIS PART IS FOR WORDPRESS CONFIGURATION:
############################################
# Time to install Wordpress:

$ wget http://wordpress.org/latest.tar.gz
$ ls
$ tar -xzvf latest.tar.gz

############################################
# Prepare MYSQL database for Wordpress installation:

$ mysql -u root -p

# And follow instructions on the screen as below:
    Enter password:

    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 5340 to server version: 3.23.54

    Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

    mysql> CREATE DATABASE databasename;
    Query OK, 1 row affected (0.00 sec)

    mysql> GRANT ALL PRIVILEGES ON databasename.* TO "wordpressusername"@"hostname"
        -> IDENTIFIED BY "password";
    Query OK, 0 rows affected (0.00 sec)

    mysql> FLUSH PRIVILEGES;
    Query OK, 0 rows affected (0.01 sec)

    mysql> EXIT
    Bye
    $

############################################
# WORDPRESS continue:
############################################
$ cp ~/wordpress/wp-config-sample.php ~/wordpress/wp-config.php
$ ls ~/wordpress/
$ sudo nano ~/wordpress/wp-config.php
$ ls /var/www/example.com
$ sudo cp -r ~/wordpress/* /var/www/example.com

# Let say that in this case scenario: /var/www/ is a default directory for our wordpress website:

$ cd /var/www/

# Take care of the ownership of wordpress files (pain in the ass with all wordpress updates, caching and securing all data):

$ sudo chown example-user:www-data * -R
$ sudo usermod -a -G www-data example-user
$ sudo chmod -R g+w /var/www/example.com
$ sudo find /var/www/example.com -type d -exec chmod g+s {} \;
$ sudo chown -R example-user:www-data /var/www

# Check ownership of all /var/www/example.com files:

$ ls -la /var/www/example.com

# In case of any troubles with upgrades, updates or editing files:
$ sudo chown example-user:www-data * -R

############################################

                 ***

############################################
# Set up NGINX for example.com
############################################

$ sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
$ sudo nano /etc/nginx/sites-available/example.com
$ sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
$ ls -l /etc/nginx/sites-enabled/

$ sudo rm /etc/nginx/sites-enabled/default
$ sudo service nginx restart && sudo service php5-fpm restart

# Check NGINX status:

$ nginx -t

# Prepare NGINX logs directories:
$ sudo mkdir /var/www/example.com/logs && sudo mkdir /var/www/example.com/logs/access.log && sudo ln -s /var/log/nginx/example.com.access.log /var/www/example.com/logs/access.log && sudo ln -s /var/log/nginx/example.com.error.log /var/www/example.com/logs/error.log

# Once again check for errors:

$ nginx -t

# Edit main nginx file, and make all necessary changes:

$ sudo nano /etc/nginx/nginx.conf

# Change log's ownership:

$ sudo chown www-data:www-data /var/www/example.com/logs -R
$ sudo chown www-data:www-data /var/log/nginx/ -R
$ sudo chown -R www-data:www-data /var/log/nginx
$ sudo chmod -R 755 /var/log/nginx
$ sudo service nginx reload
$ nginx -t

$ service nginx status

$ ps aux | grep .nginx: worker process. | awk .{print $1}.

############################################

                  ***

############################################
# Install VARNISH cache server:
############################################

$ curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
$ nano /etc/apt/sources.list
$ sudo apt-get install varnish
$ sudo nano /etc/default/varnish

###
#
    # Should we start varnishd at boot?  Set to "no" to disable.
    START=yes

    DAEMON_OPTS="-a :80 \
             -T localhost:6082 \
             -f /etc/varnish/default.vcl \
             -S /etc/varnish/secret \
             -s malloc,256m"

#
###

$ sudo nano /etc/varnish/default.vcl

###
#
    # This is a basic VCL configuration file for varnish.  See the vcl(7)
    # man page for details on VCL syntax and semantics.
    #
    # Default backend definition.  Set this to point to your content
    # server.
    #
    backend default {
    .host = "127.0.0.1";
    .port = "8080";
    }
    # Drop any cookies sent to WordPress.
    sub vcl_recv {
        if (!(req.url ~ "wp-(login|admin)")) {
            unset req.http.cookie;
        }
    }

    # Drop any cookies WordPress tries to send back to the client.
    sub vcl_fetch {
        if (!(req.url ~ "wp-(login|admin)")) {
            unset beresp.http.set-cookie;
        }
    }

    acl purge {
        "localhost";
    }

    sub vcl_recv {
            if (req.request == "PURGE") {
                    if (!client.ip ~ purge) {
                            error 405 "Not allowed.";
                    }
                    return(lookup);
            }
    if (req.url ~ "^/$") {
                unset req.http.cookie;
                }
    }
    sub vcl_hit {
            if (req.request == "PURGE") {
                    set obj.ttl = 0s;
                    error 200 "Purged.";
            }
    }
    sub vcl_miss {
            if (req.request == "PURGE") {
                    error 404 "Not in cache.";
            }
        if (!(req.url ~ "wp-(login|admin)")) {
                            unset req.http.cookie;
                    }
        if (req.url ~ "^/[^?]+.(jpeg|jpg|png|gif|ico|js|css|txt|gz|zip|lzma|bz2|tgz|tbz|html|htm)(\?.|)$") {
            unset req.http.cookie;
            set req.url = regsub(req.url, "\?.$", "");
        }
        if (req.url ~ "^/$") {
            unset req.http.cookie;
        }
    }
    sub vcl_fetch {
            if (req.url ~ "^/$") {
                    unset beresp.http.set-cookie;
            }
    if (!(req.url ~ "wp-(login|admin)")) {
                            unset beresp.http.set-cookie;
    }
    }

#
###

# Reload configuration:

$ sudo service nginx restart
$ sudo service varnish restart

# Check varnish stats:

$ varnishstat

############################################

                  ***

############################################
# ADDITIONAL PACKAGES TO INSTALL:
############################################

# PHP and cache (apc) plus additional 'must have' apps:

$ sudo apt-get install php5-tidy php-pear libpcre3-dev make php5-dev
$ sudo pear upgrade

$ sudo pecl install apc

# or:

$ sudo apt-get install php-apc

# Reload php5-fpm:

$ sudo service php5-fpm restart

############################################
# If you want to have APC cache
############################################

$ cp /usr/share/doc/php-apc/apc.php.gz /var/www/example.com/
$ sudo cp /usr/share/doc/php-apc/apc.php /var/www/example.com/
$ sudo nano /var/www/example.com/apc.php
$ sudo nano /etc/php5/conf.d/apc.ini
$ sudo ls /etc/php5/cli/conf.d
$ sudo nano /etc/php5/cli/conf.d/20-apcu.ini

# I decided to remove apc.php because I had no use for it and for security reasons:
$ sudo rm -rf /var/www/example.com/apc.php

############################################
# Additional 'after installation' follow up:
############################################

$ sudo apt-get install php5-gd php5-freetype php5-curl php5-apc php-pear php-devel httpd-devel gcc make zlib-devel pcre-devel libpcre3-dev zlib1g-dev libncurses5-dev

############################################

$ cd /var/www/example.com && sudo nano robots.txt

############################################
# ROBOTS.TXT file (allow/disallow):
############################################
    Sitemap: http://example.com/sitemap_index.xml
    # Google Image
    User-agent: Googlebot-Image
    Disallow:
    Allow: /*
    # Google AdSense
    User-agent: Mediapartners-Google
    Disallow:
    # digg mirror
    User-agent: duggmirror
    Disallow: /
    # global
    User-agent: *
    Disallow: /cgi-bin/
    Disallow: /wp-admin/
    Disallow: /wp-includes/
    Disallow: /wp-content/plugins/
    Disallow: /wp-content/cache/
    Disallow: /wp-content/themes/
    Disallow: /trackback/
    Disallow: /feed/
    Disallow: /comments/
    Disallow: /category/*/*
    Disallow: */trackback/
    Disallow: */feed/
    Disallow: */comments/
    Disallow: /*?
    Allow: /wp-content/uploads/

############################################
###
# host names setup (change 'hostname' to your's server hostname):
##
$ sudo nano /etc/hosts

###
#
    127.0.0.1       localhost
    # The following lines are desirable for IPv6 capable hosts
    ::1     ip6-localhost ip6-loopback
    fe00::0 ip6-localnet
    ff00::0 ip6-mcastprefix
    ff02::1 ip6-allnodes
    ff02::2 ip6-allrouters
    ff02::3 ip6-allhosts
    192.168.0.1  hostname
    192.168.0.1  hostname.example.com hostname
#
###

# If you don't know your's server hostname:

$ sudo hostname -F /etc/hostname

############################################


               ***
############################################
# SECURITY:
############################################
Edit files ->

$ sudo nano /etc/sysctl.conf

###
#
    # Uncomment the next two lines to enable Spoof protection (reverse-path filter)
    # Turn on Source Address Verification in all interfaces to
    # prevent some spoofing attacks
    net.ipv4.conf.default.rp_filter=1
    net.ipv4.conf.all.rp_filter=1

    # Uncomment the next line to enable TCP/IP SYN cookies
    # See http://lwn.net/Articles/277146/
    # Note: This may impact IPv6 TCP sessions too
    net.ipv4.tcp_syncookies=1
    net.ipv4.tcp_max_syn_backlog = 2048
    net.ipv4.tcp_synack_retries = 2
    net.ipv4.tcp_syn_retries = 5

    # Do not accept ICMP redirects (prevent MITM attacks)
    net.ipv4.conf.all.accept_redirects = 0
    net.ipv6.conf.all.accept_redirects = 0
    net.ipv4.conf.default.accept_redirects = 0
    net.ipv6.conf.default.accept_redirects = 0

    # Do not accept IP source route packets (we are not a router)
    net.ipv4.conf.all.accept_source_route = 0
    net.ipv6.conf.all.accept_source_route = 0
    net.ipv4.conf.default.accept_source_route = 0
    net.ipv6.conf.default.accept_source_route = 0
    #
    # Log Martian Packets
    net.ipv4.conf.all.log_martians = 1
    net.ipv4.icmp_ignore_bogus_error_responses = 1
    #
    vm.panic_on_oom=1
    kernel.panic=10

    # Ignore Directed pings
    net.ipv4.icmp_echo_ignore_all = 1

    # Ignore ICMP broadcast requests
    net.ipv4.icmp_echo_ignore_broadcasts = 1

#
###

############################################
# Bits and pieces to check and apply:
############################################

$ sudo sysctl -p

$ sudo nano /etc/host.conf

##
    # The "order" line is only used by old versions of the C library.
    order hosts,bind
    multi on
    nospoof on
##

$ sudo apt-get install dnsutils
$ host -t mx example.com
$ curl http://example.com | tail -n 4 && echo -e

############################################
# WORDPRESS CACHE PLUGIN W3C TOTAL CACHE CONFIG:
############################################
# W3C TOTAL CACHE - server side configuration:

$ sudo apt-get install php-apc php5-apcu memcached php5-memcache php-pear build-essential && sudo pecl install memcache
$ echo "extension=memcache.so" | sudo tee /etc/php5/conf.d/memcache.ini
$ echo "extension=memcache.so" | sudo tee /etc/php5/cli/conf.d/memcache.ini
$ sudo nano /etc/php5/cli/conf.d/memcache.ini
$ ps aux | grep memcache
$ sudo service varnish restart && sudo service nginx restart

############################################
# BULLETPROOF HTACCESS:
############################################
$ sudo nano /var/www/example.com/.htaccess

TODO!

############################################
# Backup example.com config file:
############################################
$ sudo cp /etc/nginx/sites-available/example.com /etc/nginx/sites-available/backup_example.com

# And rename it (if you host more than one website- your IP server will serve website in alphabetical order):

$ sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/aaa_example.com

# And remove original file from /sites-enabled/ now:

$ sudo rm /etc/nginx/sites-enabled/example.com

############################################
# Repair ownership of robots.txt:
############################################
sudo chown www-data:www-data /var/www/example.com/robots.txt


############################################
# WORDPRESS - INSTALLATION (LAST PART):
############################################
Drop the console and head to your browser; enter in the adress field:

http://example.com/wp-admin/install.php

And follow instructions to finish your installation.
Add user (please do not set your's username as 'admin')
& password (generate secure one (random, mixed numbers, letters, etc and long)).


############################################
###############%- THE END -%################
############################################
