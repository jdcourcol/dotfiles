unamestr=`uname`
if [[ "$unamestr" != "Darwin" ]]; then
    export PATH=/home/courcol/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:
else
    export PATH=/Users/courcol/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/opt/coreutils/libexec/gnubin
fi

