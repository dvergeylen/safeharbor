# safeharbor
What if one day the Internet becomes censored&#42;? It would be too late to download decentralized tools (e.g in no particular order:  [ipfs](https://github.com/ipfs/ipfs), [sslscan](https://github.com/rbsec/sslscan), [awesome-hacking](https://github.com/Hack-with-Github/Awesome-Hacking), [lynis](https://github.com/CISOfy/lynis), [c-toxcore](https://github.com/TokTok/c-toxcore), [mitmAP](https://github.com/xdavidhu/mitmAP), [cipherlist.st](https://github.com/RaymiiOrg/cipherli.st), [web2web](https://github.com/elendirx/web2web), [warberry](https://github.com/secgroundzero/warberry), [felony](https://github.com/henryboldi/felony), [bitcore](https://github.com/bitpay/bitcore), [libressl-portable](https://github.com/libressl-portable/portable), [ostinato](https://github.com/pstavirs/ostinato), [libsodium](https://github.com/jedisct1/libsodium), [gittorrent](https://github.com/cjb/GitTorrent)).

These 36 lines of code download all your starred repositories and make a local copy. This is ideal to put in cron to always have them up-to-date (including their branches) and never worry about them again. All you have to do is adapting `YOUR_USERNAME` in the file.

#### Make the script executable
`chmod +x safeharbor.h`

#### Add the script in crontab
`0 2 * * * /path/to/safeharbor.sh >/dev/null 2>&1`
(everyday at 2am, no output)

#### Contributions
Always welcome!

* &#42; or maybe you simply want to have offline backups?* :innocent:
