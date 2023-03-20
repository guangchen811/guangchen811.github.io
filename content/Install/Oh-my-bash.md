---
title: "Oh My Bash"
date: 2022-09-09T23:10:16+08:00
draft: false
tags: 
- bash
---
After using [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) on my macbook for a few days, I feel the original bash theme not elegant enough. Thus, I start searching something like oh-my-zsh for bash, then I found oh my bash.

[Oh My Bash](https://github.com/ohmybash/oh-my-bash) is an open source, community-driven framework for managing your bash configuration. Let's get started.

Oh My Bash is installed by running one of the following commands in your terminal.

#### via curl
``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
```

#### via wget
``` bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
```

The above command will execute the following commands line by line.
```bash
git clone --depth=1 https://github.com/ohmybash/oh-my-bash.git /root/.oh-my-bash
mv /root/.bashrc /root/.bashrc.omb-backup-yyyymmddhhmmss #timestamp
cp /root/.oh-my-bash/templates/bashrc.osh-template /root/.bashrc
mv -f /root/.bashrc.omb-temp /root/.bashrc
```

After the above command, you can see the basic oh-my-bash theme on your terminal.

![initial theme](/images/hello_ohmybash.png)

the default theme is `font`. you can change the variable `OSH_THEME` in the file `~/.bashrc`. All the theme can be found in [this link](https://github.com/ohmybash/oh-my-bash/wiki/Themes). I'd like to use `bakke` right now.

![bakke theme](/images/bakke.png)