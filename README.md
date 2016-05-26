# ToxShitRemover
Simple shell script to remove shit files created by Tox clients.

## Warning
This shell script is only intended to be useful for me, maybe it'll be for anyone else.  
**Be careful if you want to run this, as it simply wipe files that are used by Tox clients.**  
Files that this script deletes are for example used to store your chat logs, preferences, etc.

### Removed files
Currently this script removes the files that matches the following patterns:

| Files pattern | Files that match, description/usage       |
|:--------------|:------------------------------------------|
| `*.fmetadata` | Metadata files produced by uTox           |
| `*.new.txt`   | Logs files produced by uTox               |
| `*.hash`      | Avatars hash files produced by qTox       |
| `*.ini`       | User preferences files produced by qTox   |
| `*.db`        | Chat logs database files produced by qTox |

### Usage
```shell
Usage: ToxShitRemover.sh [option]

Options:
  --help    Display this help message.
  --delete  Delete Tox clients shit files.

```

### License
This shell script is released under the MIT license.
