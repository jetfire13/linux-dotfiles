/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 1;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 5;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "SauceCodePro Nerd Font:size=12" };
static const char dmenufont[]       = "SauceCodePro Nerd Font:size=12";
static const char col_gray1[] = "#1f1f28";
static const char col_gray2[] = "#727169";
static const char col_gray3[] = "#7fb4ca";
static const char col_gray4[] = "#dcd7ba";
static const char col_gray5[] = "#805f4e";
static const char col_cyan1[] = "#2d4f67";
static const char col_cyan2[] = "#c34043";
static const char *colors[][4]      = {
	/*               fg         bg         border     float */
	[SchemeNorm] = { col_gray4, col_gray1,  col_gray2, col_gray5 },
	[SchemeSel] =  { col_gray4, col_cyan1,  col_cyan1, col_cyan2 },
 };

static const char *const autostart[] = {
	// "alacritty", NULL,
	// "picom", NULL,
	// "slstatus", NULL,
	"dunst", NULL,
        "feh", "--bg-fill", "/home/jetfire/Pictures/Wallpapers/Wallpaper1.png", NULL,
	"nm-applet", NULL,
	"blueman-applet", NULL,
	NULL /* terminate */
};

/* tagging */
// static const char *tags[]     = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *tags[] = {"", "", "", "", "", "", "", "", ""};
static const int taglayouts[] = {  0,   0,   0,   0,   0,   0,   0,   0,   0  };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                    instance    title       tags mask     isfloating   monitor */
	{ "Gimp",                   NULL,       NULL,       0,            1,           -1 },
	{ "org.mozilla.firefox",    NULL,       NULL,       1 << 2,       0,           -1 },
	{ "Pavucontrol",            NULL,       NULL,       0,            1,           -1 },
	{ "alacritty-floating",     NULL,       NULL,       0,            1,           -1 },
	{ "feh",                    NULL,       NULL,       0,            1,           -1 },
	{ "Blueman-manager",        NULL,       NULL,       0,            1,           -1 },
	{ "steam",                  NULL,       NULL,       1 << 4,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-c", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray4, "-sb", col_cyan1, "-sf", col_gray4, NULL };
// static const char *termcmd[]  = { "st", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *termFloatingCmd[]  = { "alacritty-floating", NULL };

/*Hardware keys*/
#include <X11/XF86keysym.h>
static const char *mutevol[] = {"dwm_volume", "--toggle", NULL};
// TODO: mutemic
// static const char *mutemicp[] = {"mutemic", NULL};
static const char *downvol[] = {"dwm_volume", "--dec", NULL};
static const char *upvol[] = {"dwm_volume", "--inc", NULL};

static const char *backlightDown[] = {"bl_down.sh", NULL};
static const char *backlightUp[] = {"bl_up.sh", NULL};

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termFloatingCmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ ALTKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
	{ ALTKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
	{ ALTKEY|ShiftMask,             XK_m,      setlayout,      {.v = &layouts[2]} },
	{ ALTKEY|ShiftMask,             XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },

	/* Hardware Keys */
	{0,                             XF86XK_AudioMute,         spawn,          {.v = mutevol}},
	{0,                             XF86XK_AudioLowerVolume,  spawn,          {.v = downvol}},
	{0,                             XF86XK_AudioRaiseVolume,  spawn,          {.v = upvol}},
	{0 ,                            XF86XK_MonBrightnessUp,   spawn,          {.v = backlightUp } },
	{0 ,                            XF86XK_MonBrightnessDown, spawn,          {.v = backlightDown } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        ALTKEY,         Button1,        sigstatusbar,   {.i = 6} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	// { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

