# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

source /etc/bash_completion.d/git-prompt

Green="\[\033[0;32m\]"        # Green
IRed="\[\033[0;91m\]"         # Red
BIYellow="\[\033[1;93m\]"     # Yellow
Yellow="\[\033[0;33m\]"       # Yellow
BPurple="\[\033[1;35m\]"      # Purple

export GIT_PS1_SHOWDIRTYSTATE=1
PS1="\n\$(if [[ \$? == 0 ]]; then echo \"\[\033[0;94m\]\"; else echo \"\[\033[0;31m\]\"; fi)\342\226\210\342\226\210 (\t) [ \w ] "
PS1=$PS1'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
	echo "$(echo `git status` | grep "# Your branch is"> /dev/null 2>&1; \
	if [ "$?" -eq "0" ]; then \
		echo "$(echo `git status` | grep "# Untracked files" > /dev/null 2>&1; \
		if [ "$?" -eq "0" ]; then \
			# @4 - Clean repository - Untracked Files
			echo "'$BPurple'"$(__git_ps1 "(%s)**"); \
		else \
			echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
			if [ "$?" -eq "0" ]; then \
				# @4 - Clean repository - nothing to commit
				echo "'$Green'"$(__git_ps1 "(%s)**"); \
			else \
				# @5 - Changes to working tree
				echo "'$IRed'"$(__git_ps1 "(%s)**"); \
			fi)  "; \
		fi)"; \
	else \
		echo "$(echo `git status` | grep "# Untracked files" > /dev/null 2>&1; \
		if [ "$?" -eq "0" ]; then \
			# @4 - Clean repository - Untracked Files
			echo "'$BPurple'"$(__git_ps1 "(%s)"); \
		else \
			echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
			if [ "$?" -eq "0" ]; then \
				# @4 - Clean repository - nothing to commit
				echo "'$Green'"$(__git_ps1 "(%s)"); \
			else \
				# @5 - Changes to working tree
				echo "'$IRed'"$(__git_ps1 "(%s)"); \
			fi)  "; \
		fi)"; \
	fi)" ;\
#~ fi \
#~ else \
	#~ # @2 - Prompt when not in GIT repo
	#~ echo " '$Yellow$PathShort$Color_Off' "; \
fi)';
PS1=$PS1"\n\[\033[0m\]\342\226\210\342\226\210 "
#PS1=$PS1"\n\[\033[0m\]>> "



export EDITOR='gvim -f'
set -o vi

alias gvim='UBUNTU_MENUPROXY= gvim'
alias g='gvim'
alias QQ='exit'

export CC=clang
export CXX=clang++
alias g++='g++ -std=c++11'
alias clang++='clang++ -std=c++11'

function catkin_make_i(){
  dir=$PWD;
  cd /home/li9i/catkin_ws/;
  catkin_make_isolated --install --use-ninja;
  cd $dir;
}

function catkin_build(){
  dir=$PWD;
  cd ~/catkin_ws/;
  catkin build $1
  cd $dir;
}

# ls after cd
cd() { builtin cd "$@" && ls; }


# ROS-specific
source /opt/ros/kinetic/setup.bash
source /home/li9i/catkin_ws/devel/setup.bash
#source /home/li9i/catkin_is_ws/devel/setup.bash
#source /home/li9i/catkin_ws/devel_isolated/setup.bash
#source /home/li9i/catkin_ws/install_isolated/setup.bash

# with hokuyo the turtlebot appears as a white cube in gazebo
# with kinect it is shown as intended
export TURTLEBOT_3D_SENSOR="hokuyo"
#export TURTLEBOT_3D_SENSOR="kinect"

# Used for mitigating gazebo crash.
# When .bashrc is sourced, the following export line is not considered,
# and hence gazebo crashes. When executed within the terminal, gazebo
# starts cleanly. (!)
export LIBGL_ALWAYS_SOFTWARE=1

# Disable the touchpad
#synclient TouchpadOff=1

# core dumps
#ulimit -c unlimited
#export ROS_HOME=/home/alek/ros_home
# and then: su, echo 1 > /proc/sys/kernel/core_uses_pid

# MATLAB-specific
alias matlab='cd ~/R2014b/bin && ./matlab'
alias matlab_cmd='matlab -nodisplay -nosplash'
alias matlab_cmd_thesis='matlab -nodisplay -nosplash -r "cd /media/li9i/6A9AD14446A51251/Dropbox/alex_master_thesis/alefil/experimental"'

alias mon='xrandr --output HDMI-1 --rotate right --right-of VGA-1'
mon
alias movekeysaround='xmodmap -e "keycode 94 = grave asciitilde" && xmodmap -e "keycode 49 = z"'
movekeysaround

# Apple keyboard remaps. RUN ONCE, HERE ONLY FOR FUTURE REFERENCE
#echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
#echo options hid_apple swap_opt_cmd=1 | sudo tee -a /etc/modprobe.d/hid_apple.conf
#sudo update-initramfs -u -k all

alias 4d='python /media/li9i/elements/Pictures/var/chan/pro/threads/ch.py $1'
alias 4dd='python /home/li9i/Desktop/ch.py $1'

function matrix_rain() {
  echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|gawk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

alias matrix=matrix_rain
alias we="curl http://wttr.in/stockholm"

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }
