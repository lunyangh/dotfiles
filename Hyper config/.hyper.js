// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    // fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontFamily: '"Fira Code", Menlo, "DejaVu Sans Mono", "Lucida Console", monosp ace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // line height as a relative unit
    lineHeight: 1,

    // letter spacing as a relative unit
    letterSpacing: 0,

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    // cursorColor: 'rgba(248,28,229,0.8)', // purple
    cursorColor: 'rgba(229,229,229,0.5)', // grey
    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: true,

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#282C34',
    // backgroundColor: '#000000',

    // terminal selection color
    // selectionColor: 'rgba(248,28,229,0.3)', // purple
    selectionColor: 'rgba(229,229,229,0.2)', // gray

    // border color (window, tabs)
    borderColor: '#333',

    // custom CSS to embed in the main window
    css: '.hyper_main { border: none; }',

    // custom CSS to embed in the terminal window
    termCSS: '',
    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: true,

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    // colors: {
    //   black: '#000000',
    //   red: '#ff0000',
    //   green: '#33ff00',
    //   yellow: '#ffff00',
    //   blue: '#0066ff',
    //   magenta: '#cc00ff',
    //   cyan: '#00ffff',
    //   white: '#d0d0d0',
    //   lightBlack: '#808080',
    //   lightRed: '#ff0000',
    //   lightGreen: '#33ff00',
    //   lightYellow: '#ffff00',
    //   lightBlue: '#0066ff',
    //   lightMagenta: '#cc00ff',
    //   lightCyan: '#00ffff',
    //   lightWhite: '#ffffff'
    // },

    MaterialTheme: {
        // Set the theme variant,
        // OPTIONS: 'Darker', 'Palenight', 'Ocean', ''
        theme: '',

        // [Optional] Set the rgba() app background opacity, useful when enableVibrance is true
        // OPTIONS: From 0.1 to 1
        backgroundOpacity: '0.8',

        // [Optional] Set the accent color for the current active tab
        accentColor: '#64FFDA',

        // [Optional] Mac Only. Need restart. Enable the vibrance and blurred background
        // OPTIONS: 'dark', 'ultra-dark', 'bright'
        // NOTE: The backgroundOpacity should be between 0.1 and 0.9 to see the effect.
        vibrancy: 'dark'
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    scrollBack: 5000,

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,

    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: 'vertical',

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: false,

    // for advanced config flags please refer to https://hyper.is/#cfg
    modifierKeys: {
      altIsMeta: true
    },
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    "hypercwd",
    "hyper-pane",
    "hyperline",
    "hyper-search",
    "hyper-font-ligatures",
    "hyper-material-theme",
    "hyper-drop-file",
    "hyper-tabs-enhanced",
    // "hyper-one-dark",
    // "verminal",
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },

};
