WHAT?
====================

- Run the test/spec your cursor is currently on
- Run the file your cursor is currently in
- Run the entire test/spec you are working in
- Streaming output to tmux via vimux

This plugin currently supports
  - [Buster.js](http://busterjs.org)

The original idea and structure of the code is based on the ruby equivalent [vimux-ruby-test plugin](https://github.com/pgr0ss/vimux-ruby-test) by @pgr0ss. I just wanted the same functionality for running my JS tests.

HOW?
====================

Use any of the commands below. Map them to shortcuts in your *~/.vimrc* for easy access.

  - `RunJavaScriptFocusedTest` - run focused test/spec
  - `RunJavaScriptTestCase` - run all tests in a given file
  - `RunJavaScriptTestSuite` - run all tests in repository

MAPPINGS EXAMPLE
====================

The following mappings are scoped to work only with files Vim interprets as JavaScript. If you want to use the same shortcuts as another vimux plugin (e.g. vimux-ruby-test) then you will have to scope those mappings to ruby to avoid collisions. My personal mappings are setup as follow:

```vim
" vimux-javascript-test
" Prompt for a command to run
autocmd filetype javascript map <Leader>l :RunJavaScriptFocusedTest<CR>
autocmd filetype javascript map <Leader>j :RunJavaScriptTestCase<CR>
autocmd filetype javascript map <Leader>h :RunJavaScriptTestSuite<CR>
```

BUSTER.JS CONFIG OPTIONS
====================

By default Buster.js test runs will execute _all_ defined groups in your buster.js config file (usually just browsers and/or node.js). If you wish to filter by group (achieved manually via the `-g/--group flag` on the buster test command), which can be useful if you want to focus on just one target runtime without editing the config file, then you can set the `g:bustergroup` variable, either in your ~/.vimrc, or more usefully inside vim itself.

NOTE: You *must* use the `let` keyword to set this variable, *not* set. This is because I found global variables exposed from a vim plugin with `set` seemed to be readonly, so you could echo them but not set them. Also, you *must* quote the group name since they are strings. It may work with single word group names, but not with multiple words.

Example (assuming a test group mapped to "node" specified in your buster.js config file):

```
let: g:bustergroup="node"
```

INSTALL
====================

Most easily accomplished with [pathogen](https://github.com/tpope/vim-pathogen). From the shell:

```
cd ~/.vim/bundle
git clone git://github.com/andybeeching/vimux-javascript.git
```

TODO
===================

- Add support for other popular runners: Jasmine, Mocha, Vows, NodeUnit
- Expose global variable to turn off the auto-clear functionality
- Support for running a parent test/spec context

REQUIREMENTS
====================

- vim with ruby support (compiled +ruby)
- [vimux](https://github.com/benmills/vimux)

CONTRIBUTING
====================

While I have found no way to import external ruby code into Vim, I have used TDD to develop the core buffer parsing logic for running the focused tests. If you would like to contribute please ensure you add tests, and ensure they are passing, before sending a pull request. To install the test dependencies cd to the repo folder and run "bundler install". You can use the supplied Guard to autorun the minitest suite.

ACKNOWLEDGEMENT
====================

Once again to the authors of the vimux-ruby-test plugin for providing a reference implementation to get this plugin started, and of course @benmills for the awesome vimux plugin which facilitates such IDE shenanigans within the terminal. Vim on!

CONTRIBUTORS:
====================

- [Andy Beeching](https://github.com/andybeeching)
