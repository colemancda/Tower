# 🗼Tower

**Watching Git branches without webhook, the new commits on each branch run scripts.**

---

- Tower watch Git repogitory that you specified.
- You push a new commit. (force-push ok)
- Tower will find it by **polling**.
- Tower fetch it, run `.towerfile` that branch has.
- Tower send notifications to `Slack` (required settings for now.)

## Setup

### Configuration

Make `config.json` for running Tower.

> ⚠️ Maybe Key will be changed.

```json
{
  "workingDirectoryPath" : "~/tower/repo-name",
  "target" : {
    "gitURL" : "git@github.com:your-org/your-repo",
    "pathForShell" : null,
    "branchMatchingPattern" : "version.*",
    "maxConcurrentTaskCount" : 3
  },
  "slack" : {
    "incomingWebhookURL" : "https://hooks.slack.com/services/....",
    "channelIdentifierForLog" : "ABCD1234",
    "channelIdentifierForNotification" : "ABCD1234"
  }
}
```

### Put `.towerfile` on branch on watching git repo

```sh
#! /bin/sh

echo 'Hello Tower'

fastlane deploy
```

## Development

### Requirements

Swift 4.1

### Build

```
$ swift build
```

## Author

[@muukii](https://github.com/muukii)
