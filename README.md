<div align="center">
  <img src="https://trinitycore.info/tc_logo.png" alt="TrinityCore-Logo" height="250px">

  <h1>TrinityCore</h1>
</div>


## This Branch (Forever)

> **This is not an official TrinityCore Branch!** </br>
> This is a Community run Fork. It is not made, supported or endorsed by the TrinityCore Team. </br>
> It is up to them whether they Support this Version of WoW or if any changes made here are taken Upstream.

> This Branch runs TrinityCore against the **WoW Forever Client**. </br>
> It uses a Vanilla World (From VMaNGOS) together with the Zephras Isle Content.


## Introduction

TrinityCore is an Open Source **MMORPG** Framework based mostly in C++.

The Project is derived from **MaNGOS**, the **Massive Network Game Object Server**. </br>
It is based on the Code of that Project and has an extensive amount of Changes that </br>
Optimize, Improve and Clean Up the Code while Improving in-game Functionality.

If you wish to Contribute, feel free to make a [Pull Request on GitHub](https://github.com/TrinityCore/TrinityCore/pulls).

For further information on the TrinityCore Project, please visit our [Website](https://www.trinitycore.org).


## Install

[Build the Core like Normal](https://trinitycore.info/en/install/Core-Installation) using the Source Code from this Repository, then:

**1. Databases** </br>
Download the latest Forever Database from the Releases Page, unpack it and put both SQL Files into the Folder you Start the World-Server from. </br>
On the first Start, the World-Server's Auto-Setup imports them and applies all additional Updates from the SQL Folder in the Source Code Directory.

**2. Config.** </br>
The Forever Client needs these Settings:

`worldserver.conf`
```
RealmID = 70
Expansion = 0
Network.SkipBuildAuthKeyCheck = 1
Network.EnterEncryptedModeRegionGroup = 8
```

`bnetserver.conf`
```
Realm.CfgContentSetID = 137

CertificatesFile = "./<Your Certificate File>.pem"
PrivateKeyFile = "./<Your Private Key File>.pem"

LoginREST.ExternalAddress = trinity.actual.battle.net
LoginREST.LocalAddress = trinity.actual.battle.net
```

**3. Login.** </br>
The Game Connects to `trinity.actual.battle.net` over TLS, so on the Client PC needs to have:

**1.** A Hosts File Entry for `127.0.0.1 trinity.actual.battle.net` </br>
**2.** A Certificate for `trinity.actual.battle.net` Signed by a Root CA the Client PC Trusts. </br>
**3.** WoW Started through the [Forever Launcher](https://github.com/PixelCattt/Forever-Launcher), which adjusts the Server the Game Connects to when Logging In.


## Requirements

Software Requirements for Windows, Linux and MacOS are available in the [Wiki](https://trinitycore.info/en/install/requirements).


## Reporting Issues

Issues can be reported via [GitHub Issues](https://github.com/PixelCattt/TrinityCore-Forever/issues).

Please take the Time to review existing Issues before submitting your own to prevent Duplicates.

For more Information on how to properly report an Issue, please read the [Issue Guide](https://community.trinitycore.org/topic/37-the-trinitycore-issuetracker-and-you/). </br>
Invalid or Incorrect/Poorly formed Reports will be Deleted.


## Submitting Fixes

Fixes are submitted via [GitHub Pull Requests](https://github.com/PixelCattt/TrinityCore-Forever/pulls).

Please take the Time to review existing PRs before submitting your own to prevent Duplicates.

For more Information on how to properly submit a Pull Request, please read [how to maintain a remote Fork](https://community.trinitycore.org/topic/9002-howto-maintain-a-remote-fork-for-pull-requests-tortoisegit/). </br>
Invalid or Incorrect/Poorly formed PRs will be Deleted.


## Authors & Contributors

[List of Authors & Contributors](AUTHORS)


## Copyright

[GPL 2.0](COPYING)
