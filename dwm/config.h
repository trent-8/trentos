/* See LICENSE file for copyright and license details. */

/* appearance */
#include <X11/X.h>
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Symbols Nerd Font Mono:size=10","Roboto:size=16" };
static const char grey1[]       = "#010101";
static const char grey2[]       = "#1f1f1f";
static const char grey3[]       = "#4d4d4d";
static const char grey4[]       = "#808080";
static const char grey5[]       = "#a4a4a4";
static const char grey6[]       = "#cacaca";
static const char grey7[]       = "#f2f2f2";
static const char box_sel[]    = "#5d5d5d";
static const char box_norm[]   = "#3d3d3d";
static const char border_sel[]  = "#908070";
static const char border_norm[] = "#708090";
static const char *colors[][3]      = {
	/*                      forground   background  border   */
	[SchemeIconBoxNorm] = { grey3,  NULL,  NULL },
	[SchemeIconBoxSel]  = { grey4,  NULL,  NULL },
	[SchemeIconBoxUrg]  = { grey3,  NULL,  NULL },

	[SchemeIconNorm] = { grey6, NULL, NULL },
	[SchemeIconSel]  = { grey7, NULL, NULL },
	[SchemeIconUrg]  = { grey6,  NULL, NULL },

	[SchemeLayoutNorm] = { grey6, NULL, NULL },
	[SchemeLayoutSel]  = { grey5, NULL, NULL },

	[SchemeClientNorm] = { grey5, NULL, border_norm },
	[SchemeClientSel]  = { grey7, NULL, border_sel },

	[SchemeStatusNorm] = { grey5, NULL, NULL },
	[SchemeStatusSel]  = { grey7, NULL, NULL },

	[SchemeBarNorm]  = { grey2, NULL, NULL },
	[SchemeBarSel]  =  { grey2, NULL, NULL },
};

/* tagging */
static const char *tags[] = {
	"", // terminal
	"󰖟", // browser
	"󰉋", // general
	"", // code
	"󰝚", // spotify
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class        instance  title      tags mask       isfloating   monitor */
	{ "Alacritty",  NULL,     NULL,           1,         0,           -1 },
	{ "firefox",    NULL,     NULL,      1 << 1,         0,           -1 },
	{ "Thunar",     NULL,     NULL,      1 << 2,         0,           -1 },
	{ "Code",       NULL,     NULL,      1 << 3,         0,           -1 },
	{ "vlc",        NULL,     NULL,      1 << 4,         0,            0 }
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "tiling",   tile },    /* first entry is default */
	{ "floating", NULL },    /* no layout function means floating behavior */
	{ "monocle",  monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *startup[]= { "./trentos/startup.sh", NULL };
static const Arg autostartarg= {.v = startup };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_t,      spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_s,      spawn,          SHCMD ("vlc ~/Music/Minecraft Volume Beta/*.mp3 --loop")},
	{ MODKEY,                       XK_c,      spawn,          SHCMD ("code")},
	{ MODKEY,                       XK_b,      spawn,          SHCMD ("firefox")},
	{ MODKEY,                       XK_a,      spawn,          SHCMD ("arandr")},
	{ MODKEY,                       XK_e,      spawn,          SHCMD ("thunar")},
	{ MODKEY,                       XK_n,      spawn,          SHCMD ("terminator -e 'python ~/trentos/notes.py'")},
	{ MODKEY,                       XK_z,      spawn,          SHCMD ("alacritty -e 'bluetuith --adapter-states=\"scan:yes\"'")},
	{ MODKEY,                       0xfd1d,    spawn,          SHCMD ("shotgun -s")},
	{ MODKEY,                       XK_x,      spawn,          SHCMD ("~/.screenlayout/apply-layout.sh")},
	{ 0,                            0x1008ff02, spawn,         SHCMD ("brightnessctl set +2%")},
	{ 0,                            0x1008ff03, spawn,         SHCMD ("brightnessctl set 2%-")},
	{ 0,                            0x1008ff11, spawn,         SHCMD ("pactl set-sink-volume 0 -2%")},
	{ 0,                            0x1008ff12, spawn,         SHCMD ("pactl set-sink-mute 0 toggle")},
	{ 0,                            0x1008ff13, spawn,         SHCMD ("pactl set-sink-volume 0 +2%")},
	{ 0,                            0x1008FF14, spawn,         SHCMD ("playerctl play-pause")},
	{ 0,                            0x1008FF16, spawn,         SHCMD ("playerctl previous")},
	{ 0,                            0x1008FF17, spawn,         SHCMD ("playerctl next")},
	{ MODKEY,                       XK_v,      spawn,          SHCMD ("qemu-system-x86_64 -m 12G -cdrom vm-install.iso -cpu host -smp $(nproc) -boot order=d -drive file=vm,format=raw -accel kvm")},
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

