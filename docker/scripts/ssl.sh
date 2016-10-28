#!/bin/bash
# Script to create SSL certificates and keys for use inside this Docker container.

# script variables
version="0.0.1"
author="Synoa GmbH"
author_url="<https://synoa.de>"
github_url="https://github.com/synoa/synoa.github.io"
github_issue_title="[ssl.sh]"
github_issues="$github_url/issues"
program_name="$(basename "$0")"

# Color variables
green="\e[;92m"
red="\e[;31m"
blue="\e[;94m"
reset="\e[;0m"

# Check sign and cross sign
checksign="$green✓$reset "
cross="$red❌$reset "

# script specific variables
# verbose mode
verbose=""
# default output directory
default_out="$(pwd)"

# Print out version information
version() {
  write_message "v$version" \
  "by $author $author_url" \
  "" \
  "Report Issues on $github_issues" \
  "Please write $github_issue_title inside the title of your issue!"
  exit 0
}

usage() {
  printf "%s\n" "$program_name name [-v] [version] [usage]" \
  "" \
  "Basic usage:" \
  "    $program_name myappname" \
  "" \
  "Will create myappname.cert, myappname.key and 000-default.conf inside the script directory." \ ""

  echo -e "
    usage  & Show this usage message
    version & Show version and author info
    -v, verbose    & Show more text and info during script execution
    " | column -s\& -t

    exit 0
}

write_message() {
  if [ "$verbose" != "" ]; then
    printf "%s\g " "$@"
    printf "%s\n" ""
  fi
}

write_error() {
  echo -e "[$cross] ERROR: " "$@"
  exit 1
}

write_warn() {
  if [ "$verbose" != "" ]; then
    echo -e "[$blue""WARNING$reset]" "$@"
  fi
}

# generate a key file
generate_key() {
  # Ask before overwriting an existing key. Overwriting an existing key can break virtual hosts!
  if [ -f "$default_out/$app_name.key" ]; then
    echo -e "Attempt to overwrite existing key in $default_out/$app_name.key. This might break existing virtual hosts."
    echo -e "Continue? [Y/n]: "
    read answer
    if [ "$answer" != "Y" ]; then
      echo -e "Abort key overwirte."
      exit 0
    fi
  fi
  # Generate the key
  openssl genrsa -out "$default_out/$app_name.key" 2048
  # Check if it was created
  if [ ! -f "$default_out/$app_name.key" ]; then
    write_error "Key generation failed. Exit code from openssl: $?"
  else
    write_message "$checksign Done! New Key generated in file $default_out/$app_name.key"
  fi
}

generate_cert() {
  write_message "Creating SSL certificate $app_name.crt, using key file $app_name.key" "You will be prompted some questions from the openssl tool. Answer them to create your new self-signed SSL Certificate."

  # create the new SSL certificate
  openssl req -new -x509 -key "$default_out/$app_name.key" -days 365 -sha256 -out "$default_out/$app_name.crt"

  if [ "$?" != 0 ]; then
    write_error "There was an error while creating the certifacte file. OpenSSL exit code: $?"
  fi

  write_message "Created certificate in $default_out/$app_name.crt"
}

get_apache_config_file() {
  cat <<EOF
<VirtualHost _default_:80>
  ServerAdmin webmaster@localhost
  ServerName $1.local

  DocumentRoot /var/www/html/

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined

  <Directory "/var/www/html/">
    AllowOverride all
    Require all granted
  </Directory>
</VirtualHost>

<VirtualHost _default_:443>
  ServerAdmin webmaster@localhost
  ServerName $1.local

  SSLEngine on
  SSLCertificateFile /etc/ssl/certs/$1.crt
  SSLCertificateKeyFile /etc/ssl/private/$1.key

  DocumentRoot /var/www/html/

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined

  <Directory "/var/www/html/">
    AllowOverride all
    Require all granted
  </Directory>
</VirtualHost>
EOF
}

generate_apache_config() {
  vhost_config_file_content=$(get_apache_config_file "$1")
  echo "$vhost_config_file_content" > "$default_out/000-default.conf"
}

generate_apache_config "$1"

main() {
  # Prevent execution if no name is given.
  if [[ "$app_name" = "" ]]; then
    write_error "Cannot create certificate, key, and config without an app name. See '$program_name usage'."
  fi

  write_message "Creating certficiate '$app_name.crt', '$app_name.key', and apache2 config for '$app_name.local'"

  generate_apache_config "$app_name"
  generate_key
  generate_cert && echo -e  "$checksign""Done!"
}

# Read in all the arguments as long as there are any
while (( "$#" )); do
  arg=$1

  case $arg in

    'usage')
      usage
      ;;

    '-v' | 'verbose')
      verbose="true"
      ;;

    'version')
      version
      ;;

    *)
      app_name="$1"
      ;;
  esac
# Shift arguments, this way all arguments can be operated on before
# the main function is running.
shift
done

main
