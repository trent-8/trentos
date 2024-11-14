#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias winvm="qemu-system-x86_64 -m 12G -cpu host -smp $(nproc) -boot order=d -drive file=vm,format=raw -accel kvm"
PS1='[\u@\h \W]\$ '