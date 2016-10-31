# Docker scripts

Here you will find scripts related to managing Docker. Each script should implement a `usage` function, so calling `scriptname usage` should give you more information about each script.

# Documentation

## vhost.sh

Create a self-signed SSL certficiate, key, and `000-default.conf` file for use inside a Docker container, e.g. when using Apache. See `vhost.sh usage` for more.

### vhost - Install
Copy the script into your `.docker` directory and make it executable with `chmod +x vhost.sh`.

### vhost - Usage

See `vhost.sh usage`.

```txt
vhost.sh name [-v] [version] [usage]

Basic usage:
    vhost.sh myappname

Will create myappname.cert, myappname.key and 000-default.conf inside the script directory.

    usage             Show this usage message
    version           Show version and author info
    -v, verbose       Show more text and info during script execution
```
