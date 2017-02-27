# `ENTRYPOINT` and `entrypoint.sh`
> `entrypoint` is used to run programs inside a docker container with custom parameters on startup

By using `ENTRYPOINT` in a Dockerfile or `entrypoint` inside docker-compose one can specify a program (e.g. a shell script, most of the time `entrypoint.sh` or `docker-entrypoint.sh`) to run on start and pass down arguments. A very basic shell program is shown below.

```sh
#!/bin/sh

echo "Got $# arguments"
echo "Argument list: $@"
```

If we save this file as `entrypoint.sh` and make it executable (`chmod +x entrypoint.sh`) it can be set as entrypoint in a docker image as follows.

```dockerfile
FROM alpine:3.5
MAINTAINER Kevin Gimbel <docker@kevingimbel.com>

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
```

This small Dockerfile tells the docker engine to get the `alpine` image in version `3.5`, copy the `entrypoint.sh` file to `/` and make it the entrypoint script with `ENTRYPOINT ["/entrypoint.sh"]`. If we now build this into an image with `docker build -t synoa/example-entrypoint:1.0 .` we can execute it like so:
```sh
$ docker run --rm synoa/example-entrypoint:1.0 "test" "Lorem Ipsum" 12
Got 3 arguments
The arguments are: test Lorem Ipsum 12
```

As you can see all the arguments (`"test" "Lorem Ipsum" 12`) were passed to the script and then printed to the console with `echo`. In Bash/Shell Scripting `$#` holds the number of arguments and `$@` holds all arguments as array.

Now if we adjust our script to output a `Key:Value` pair which requires the script to be run with at least 2 parameters we can see that the container is exited when run with too less parameters. The new `entrypoint.sh`:

```sh
#!/bin/sh

if [ "$#" -lt 2 ]; then
  echo "Not enough arguments."
  echo "Usage: $0 <Key> <Value>"
  exit 1
fi

echo "Got Key Value pair"
echo "$1: $2"
```

Running with just one argument the container is exited because the script insides failes and returns an exit code of `1`.

```sh
$ docker run --rm synoa/example-entrypoint:1.1 "test"
Not enough arguments.
Usage: /entrypoint.sh <Key> <Value>
```

If we run the container and pass in the required two arguments, `Key` and  `Value`, the `if` statement is true and the code at the bottom of the script is executed.

```sh
$ docker run --rm synoa/example-entrypoint:1.1 "test" "true"
Got Key Value pair
test: true
```

All examples shown above are available as images from Docker Hub. By copying the `docker run` commands into a terminal the images will be pulled and executed. Feel free to experiment further, `alpine` is a good starting point because of its size (~`2MB`).

## Further Reading

- [docker compose docs](https://docs.docker.com/compose/compose-file/#/entrypoint)
- [docker docs](https://docs.docker.com/engine/reference/builder/#/entrypoint)
