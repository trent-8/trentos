# run xsession if it exists
if [ -f ~/.xsession ]; then
    source ~/.xsession
fi

exec dwm