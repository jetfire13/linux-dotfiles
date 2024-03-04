/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const int startwithgaps[] = {1}; /* 1 means gaps are used by default, this can be customized for each tag */
static const unsigned int gappx[] = {
    4};                              /* default gap between windows in pixels, this can be customized for each tag */
static const unsigned int snap = 32; /* snap pixel */
static const int showbar = 1;        /* 0 means no bar */
static const int topbar = 0;         /* 0 means bottom bar */
static const int user_bh =
    25; /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int vertpad = 0; /* vertical padding of bar */
static const int sidepad = 0; /* horizontal padding of bar */
static const char *fonts[] = {"TerminessNerdFont-Bold:pixelsize=18:antialias=true:autohint=true",
                              "JoyPixels:style=Bold:pixelsize=16:antialias=true:autohint=true"};
static const char dmenufont[] = "monospace:size=10";
static const char col_gray1[] = "#000000";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#dddfff";
static const char col_gray4[] = "#ffffff";
static const char col_gray5[] = "#805f4e";
static const char col_cyan1[] = "#005577";
static const char col_cyan2[] = "#00ffff";
static const char *colors[][4] = {
    /*               fg         bg         border     float */
    [SchemeNorm] = {col_gray3, col_gray1, col_gray2, col_gray5},
    [SchemeSel] = {col_gray4, col_cyan1, col_cyan1, col_cyan2},
};

static const char *const autostart[] = {"alacritty",
                                        NULL,
                                        "picom",
                                        NULL,
                                        "slstatus",
                                        NULL,
                                        "dunst",
                                        NULL,
                                        "clipmenud",
                                        NULL,
                                        "feh",
                                        "--bg-fill",
                                        "/home/jetfire/Pictures/WallPapers/dmc5.jpg",
                                        NULL,
                                        NULL /*terminate*/};

/* tagging */
static const char *tags[] = {" ", " ", " ", " ", " ", "󰇧 ", " ", " ", " "};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Gimp", NULL, NULL, 0, 1, -1},
    {"Firefox", NULL, NULL, 1 << 8, 0, -1},
    {"alacritty-floating", NULL, NULL, 0, 1, -1},
};

/* layout(s) */
static const float mfact = 0.55;     /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;        /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod1Mask
#define WINKEY Mod4Mask

#define TAGKEYS(KEY, TAG)                                                                                              \
    {MODKEY, KEY, view, {.ui = 1 << TAG}}, {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},                  \
        {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                                                              \
        {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                                                                     \
    {                                                                                                                  \
        .v = (const char *[])                                                                                          \
        {                                                                                                              \
            "/bin/sh", "-c", cmd, NULL                                                                                 \
        }                                                                                                              \
    }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = {"dmenu_run", "-m",      dmenumon, "-fn",    dmenufont, "-nb",     col_gray1,
//                                 "-nf",       col_gray3, "-sb",    col_cyan, "-sf",     col_gray4, NULL};
static const char *dmenucmd[] = {"dmenu_run", NULL};
static const char *termcmd[] = {"alacritty", NULL};
static const char *termcmdfloat[] = {"alacritty-floating", NULL};
static const char *thunar[] = {"thunar", NULL};

/*Volume keys*/
#include <X11/XF86keysym.h>
static const char *mutevol[] = {"/usr/share/scripts/dwm_volume", "--toggle", NULL};
static const char *mutemicp[] = {"mutemic", NULL};
static const char *downvol[] = {"/usr/share/scripts/dwm_volume", "--dec", NULL};
static const char *upvol[] = {"/usr/share/scripts/dwm_volume", "--inc", NULL};

/*Screenshots*/
static const char *shotnow[] = {"/usr/share/scripts/dwm_screenshot", "--now", NULL};
static const char *shotwin[] = {"/usr/share/scripts/dwm_screenshot", "--win", NULL};
static const char *shotarea[] = {"/usr/share/scripts/dwm_screenshot", "--area", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    /* Hardware Keys */
    {0, XF86XK_AudioMute, spawn, {.v = mutevol}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = downvol}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = upvol}},

    /*Scrinshots*/
    {0, XK_Print, spawn, {.v = shotnow}},
    {WINKEY, XK_Print, spawn, {.v = shotwin}},
    {MODKEY, XK_Print, spawn, {.v = shotarea}},
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY, XK_Return, spawn, {.v = termcmdfloat}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_e, spawn, {.v = thunar}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_q, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY | ShiftMask, XK_f, fullscreen, {0}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_minus, setgaps, {.i = -5}},
    {MODKEY, XK_equal, setgaps, {.i = +5}},
    {MODKEY | ShiftMask, XK_minus, setgaps, {.i = GAP_RESET}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = GAP_TOGGLE}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
        TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7) TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function        argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
