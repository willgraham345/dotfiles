Basic syntax for this guy
```shell
sudo update-alternatives --install <link-update-alternatives-uses> <nameForExe> <location-you-installed-it> <priority-number>
```
I typically have my alternatives in `/etc/alternatives/<nameForExe>`
- This means that I can have my 
Make sure the installation for the program is in `usr/bin/update-alternatives` or you will have **ISSUES**


```shell
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 --slave /usr/bin/g++ g++ /usr/bin/g++-11 --slave /usr/bin/gcov gcov /usr/bin/gcov-11
```


CMake example:
```shell
wget https://github.com/Kitware/CMake/releases/download/v3.31.3/cmake-3.31.3-linux-x86_64.tar.gz
tar -xvzf cmake-3.31.3-linux-x86_64.tar.gz
sudo mv <cmake_version> /opt/<cmake-3.31.3>
sudo update-alternatives --install /usr/local/bin/cmake cmake /opt/<cmake-version> cmake<priority-number

```
