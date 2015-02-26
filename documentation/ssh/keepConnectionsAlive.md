# SSH get lost after short period of time

You can set a ping to keep the ssh connection open

Create a file in /home/[user]/.ssh/config

```
# ssh configuration file

Host *
  ServerAliveInterval 300
  ServerAliveCountMax 3
```

