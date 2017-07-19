[![Build Status](https://travis-ci.org/dvergeylen/safeharbor.svg?branch=master)](https://travis-ci.org/dvergeylen/safeharbor)

# safeharbor
What if one day the Internet becomes censored&#42;? It would be too late to download decentralized tools (e.g in no particular order:  [ipfs](https://github.com/ipfs/ipfs), [sslscan](https://github.com/rbsec/sslscan), [awesome-hacking](https://github.com/Hack-with-Github/Awesome-Hacking), [lynis](https://github.com/CISOfy/lynis), [c-toxcore](https://github.com/TokTok/c-toxcore), [mitmAP](https://github.com/xdavidhu/mitmAP), [cipherlist.st](https://github.com/RaymiiOrg/cipherli.st), [web2web](https://github.com/elendirx/web2web), [warberry](https://github.com/secgroundzero/warberry), [felony](https://github.com/henryboldi/felony), [bitcore](https://github.com/bitpay/bitcore), [libressl-portable](https://github.com/libressl-portable/portable), [ostinato](https://github.com/pstavirs/ostinato), [libsodium](https://github.com/jedisct1/libsodium), [gittorrent](https://github.com/cjb/GitTorrent), ...).

These 64 lines of bash download all your starred repositories and make a local copy. It can also delete old previous clones of repos not starred anymore. This is ideal to put in cron to always have them up-to-date (*including their branches*) and never worry about them again. **All you have to do is adapting `GITHUB_USERNAME` in the file**.

#### Installation

##### Make the script executable
`chmod +x safeharbor.h`

##### Add the script in crontab
`0 2 * * * /path/to/safeharbor.sh >/dev/null 2>&1`

(everyday at 2am, no output)

#### FAQ

##### What if I star a new repo?
It will be fetched next time the script is executed (you would better always do that from the same folder)

##### What if a repo I starred is updated? Or has new branches?
The local folders containing the repos are updated and new branches are also downloaded (thanks `git fetch --all`!).

##### What if I unstar a repo?
Nothing happens unless you use `--strict-mode`.

* Normal mode will leave the local folder as is and won't fetch any updates nor delete anything (default).
* Strict mode will remove the local folder also

##### What if I have other files/folders in the same working directory?
Nothing happens unless you use `--strict-mode` where all files/folders not related to starred repos **will be deleted**.

#### Contributions
Always welcome!

*&#42; or maybe you simply want to have offline backups?* :innocent:
