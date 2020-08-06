# Steps to follow to configure your terminal

- Move `bash_profile` to your home directory from `terminal-configuration` directory


  ```mv terminal-configuration/bash_profile ~/```

- Rename your `bash_profile` to `.bash_profile`


  ```mv ~/bash_profile ~/.bash_profile```

- Copy `terminal-configuration` directory from `tools` to your home directory


  ```mv terminal-configuration ~/```

- Rename the directory


  ```mv ~/terminal-configuration ~/.terminal-configuration```

- Customize your terminal username

  - Open `.bash.profile` in your favorite text editor and edit the following line


```export PS1="$red"{custom_name}"$green\$(__git_ps1)$blue \W```


Replace `{custom_name}` with your own text within the double quotes

- Source the `.bash_profile`


  ```source ~/.bash_profile```
