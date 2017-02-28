# Logstash Configuration
> Notes on how to configure Logstash parsing

Logstash uses its own Format for writing configuration files. Basically, one always defines three "blocks": `input`, `filter`, and `outpit`. `filter` may be omitted if logs should not be filtered.

```
input {
  stdin {}
}

output {
  stdout {}
}
```

The above example configuration will read log data from [Stdin](https://en.wikipedia.org/wiki/Standard_streams#Standard_input_.28stdin.29) and write it to [Stdout](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29). This doesn't make much sense but it's the most-minimal setup. The interesting part starts when we introduce the third block, `filter`.

```
input {
  stdin {}
}

filter {
  grok {
    match => ["message", "%{LOG_LEVEL:log_level} %{TIMESTAMP_ISO8601:timestamp} %{GREEDYDATA:log_message}"]
  }
}

output {
  stdout {}
}
```

In the above configuration example the `filter` block is added. Inside we define a [`grok` filter](https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html) which matches a log line in the format similar to "ERROR 2017-02-28 15:28:18,775 There has been an error and thing went down.". After parsing, this log line looks as follows:

```json
{
  "log_level": "ERROR",
  "timestamp": "2017-02-28 15:28:18,775",
  "log_message": "There has been an error and thing went down."
}
```

After parsing this log can be indexed into Elasticsearch for further analysis. There are a lot of predefined Grok patterns in the [official repository](https://github.com/logstash-plugins/logstash-patterns-core/tree/master/patterns) and on [Grok Debugger](http://grokdebug.herokuapp.com/patterns).

If none of these patterns matches as desired, Logstash allows for own patterns to be specified. Patterns are "just" regular expressions and can be stored in a simple file (without extensions), e.g. `synoa_patterns`:
```
SYNOA_VERSION [0-9+\.?]+([a-zA-Z0-9\-\.]+)?
```

To include the patterns we need to load them in the `logstash.conf` file like so:

```
filter {
  grok {
    patterns_dir => ["/path/to/pattern_dir/"]
    match => ["message", "%{LOG_LEVEL:log_level} %{JAVACLASS:class} %{SYNOA_VERSION:version} %{GREEDYDATA:log_message}"]
  }
}
```

Parsing the following three log lines...

```
ERROR 2017-02-28 15:28:18,775 de.synoa.example.logstash 0.0.1-rc4 There has been an error and thing went down.
INFO 2017-02-28 15:28:18,789 de.synoa.example.staticserver 1.0.0 ClassB initialized and running on tcp 127.0.0.1:1337
WARNING 2017-02-28 15:28:18,814 de.synoa.example.thing 1.2.45.3-rc6 Totally not a good version number.
```

... we get back the fields below

```
{
  "log_level": "ERROR",
  "timestamp": "2017-02-28 15:28:18,775"
  "class": "de.synoa.example.logstash",
  "version": "0.0.1-rc4",
  "log_message": "There has been an error and thing went down."
}, {
  "log_level": "INFO",
  "timestamp": "2017-02-28 15:28:18,789"
  "class": "de.synoa.example.staticserver",
  "version": "1.0.0",
  "log_message": "ClassB initialized and running on tcp 127.0.0.1:1337"
}, {
  "log_level": "WARNING",
  "timestamp": "2017-02-28 15:28:18,814"
  "class": "de.synoa.example.thing",
  "version": "1.2.45.3-rc6",
  "log_message": "Totally not a good version number."
}
```

## Drop unmatched / failed logs

One might want to drop logs which do not match the provided pattern(s). Luckily, Logstash has a way of doing this. If a log line does not match any of the provided patterns it is is assigned the `_grokparsefailure` tag. Based on this tag we can then drop all these lines before sending them to our output by adding the following `if` statement to the `filter` block.

```txt
filter {
  grok {
    break_on_match => false
    match => ["message", "%{LOGLEVEL:log_level} + %{TIMESTAMP_ISO8601:timestamp} %{JAVACLASS:class}:\s+%{WORD:method} \| %{GREEDYDATA:log_message}"]
  }
  if "_grokparsefailure" in [tags] {
    drop {}
  }
}
```

`drop {}` will simply remove the log line from being sent to the output. This way, all lines that do not match our pattern(s) are ignored.

## Further Reading & Resources

Official elastic resources:

- ["Logstash Output Configuration"](https://www.elastic.co/guide/en/beats/filebeat/current/logstash-output.html)
- ["Multiline match Plugin"](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-multiline.html)
- ["Grok Introduction"](https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html)
- ["Basic Logstash Configuration Guide"](https://www.elastic.co/guide/en/logstash/current/config-examples.html)

["Grok Debugger"](http://grokdebug.herokuapp.com/) is a great in-browser app for testing out and learning how to write Grok filters.
