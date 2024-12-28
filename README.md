# ansible

打包进了控制`Windows`的依赖

## 使用

```shell
#!/bin/bash

# 设置别名
alias ansible="docker run -ti --rm -v ~/.ssh:/root/.ssh -v ~/.aws:/root/.aws -v /data/app/ansible:/apps -w /apps buyfakett/ansible ansible"

# 设置别名
alias ansible-playbook=" docker run -ti --rm -v ~/.ssh:/root/.ssh -v ~/.aws:/root/.aws -v /data/app/ansible:/apps -w /apps buyfakett/ansible ansible-playbook"
```

## 注意

在`Windows`端需要运行`ConfigureRemotingForAnsible.ps1`
