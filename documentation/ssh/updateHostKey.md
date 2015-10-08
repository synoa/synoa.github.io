# Update a Servers Host Key

It can happen that a remote Server's SSH Key changes. If this is the case you'll see an error message equal to the one below when trying to connect to the server.

```sh
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
e4:08:d0:1c:bf:ef:8b:f2:3e:9d:17:fe:2e:22:c0:67.
Please contact your system administrator.
Add correct host key in /home/YOURUSERNAME/.ssh/known_hosts to get rid of this message.
Offending RSA key in /home/YOURUSERNAME/.ssh/known_hosts:25
  remove with: ssh-keygen -f "/home/YOURUSERNAME/.ssh/known_hosts" -R 111.111.111.111
RSA host key for 111.111.111.111 has changed and you have requested strict checking.
Host key verification failed.
```

Not so nice, is it? Anyway, we now need to remove that specific key from the `/home/YOURUSERNAME/.ssh/known_hosts` file and the error message even tells us how: By using `ssh-keygen -f $file -R IP` - $file is the `know_hosts` file and IP is either the IP (`111.111.111.111` in the example above) or an URL like `example.com`. After running `ssh-keygen -f "/home/YOURUSERNAME/.ssh/known_hosts" -R 111.111.111.111` in a terminal the key for this host is removed from the file.

Next we need to verify the Fingerprint of the Server. Depending on the Hosting Company you'll maybe find a fingerprint in the backend or CPanel, but you can also get it from the command line. ([Via this StackOverflow Thread](http://unix.stackexchange.com/a/126911/136550))

```sh
$ file=$(mktemp)
$ ssh-keyscan host > $file 2> /dev/null
$ ssh-keygen -l -f $file
521 de:ad:be:ef:de:ad:be:ef:de:ad:be:ef:de:ad:be:ef host (ECDSA)
4096 8b:ad:f0:0d:8b:ad:f0:0d:8b:ad:f0:0d:8b:ad:f0:0d host (RSA)
$ rm $file
```

So with our example host 111.111.111.111:

```sh
$ file=$(mktemp)
$ ssh-keyscan 111.111.111.111 > $file 2> /dev/null
$ ssh-keygen -l -f $file
521 de:ad:be:ef:de:ad:be:ef:de:ad:be:ef:de:ad:be:ef host (ECDSA)
4096 8b:ad:f0:0d:8b:ad:f0:0d:8b:ad:f0:0d:8b:ad:f0:0d host (RSA)
$ rm $file
```

These few lines create a temporary file (`$(mktemp)`) assigned to the `$file` variable. Then grab the Key information from the remote Server `ssh-keyscan 111.111.111.111` and outputs them to the file `> $file` while trashing errors to `2> /dev/null` (`/dev/null` is like a black hole). Next, we generate the key with `ssh-keygen -l -f $file` from the files content. `-l` means "show Fingerprint of the file" and `-f` tells `ssh-keygen` to use a file. The next line(s) are our RSA key and the ECDSA key. We can now remove the file.

Since we already removed the key from the know_hosts file (see above), we can now try to re-connect to the server and will be prompted to verify the Fingerprint and IP. The prompt looks like this.

```sh
The authenticity of host 'example.com (111.111.111.111)' can't be established.
RSA key fingerprint is e4:08:d0:1c:bf:ef:8b:f2:3e:9d:17:fe:2e:22:c0:67.
Are you sure you want to continue connecting (yes/no)?
```

If the RSA key fingerprint matches the RSA fingerprint we just created we can type 'yes' and connect. The new Key is now added to the `~/.ssh/know_hosts` file and everything is good again.
