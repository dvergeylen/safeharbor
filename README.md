[![Build Status](https://travis-ci.org/dvergeylen/safeharbor.svg?branch=master)](https://travis-ci.org/dvergeylen/safeharbor)

# safeharbor
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
