WHAT?
====================

- Run the test/spec your cursor is currently on
- Run the file your cursor is currently in
- Run the entire test/spec you are working in
- Streaming output to tmux via vimux

This plugin currently supports
  - [Buster.js](http://busterjs.org)

The original idea and structure of the code is based on the ruby equivalent [vimux-ruby-test plugin](https://github.com/pgr0ss/vimux-ruby-test) by @pgr0ss. I just wanted the same functionality for running my JS tests.

REQUIREMENTS
====================

- vim with ruby support (compiled +ruby)
- [vimux](https://github.com/benmills/vimux)

INSTALL
====================

Most easily accomplished with [pathogen](https://github.com/tpope/vim-pathogen). From the shell:

```
cd ~/.vim/bundle
git clone git://github.com/andybeeching/vimux-javascript.git
```

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

BUSTER.JS USER OPTIONS
====================

The plugin exposes two variables for users to set, either directly or through calling associated utility methods. The latter can be combined with key mappings to provide custom shortcuts if desired.

CONFIGURATION GROUP

By default Buster.js test runs will execute _all_ defined groups in your buster.js config file (usually just browsers and/or node.js). If you wish to filter by group (achieved manually via the `-g/--group flag` on the `buster test` command), which can be useful if you want to focus on just one target runtime without editing the config file, then you can specify the group by:

```vim
" In ~/.vimrc
" Setting a default config group (e.g. "node" or "browser")
let g:bustergroup="node"

" From Vim
" Where param is name of the group
:BusterSetGroup "Browser Tests"

" Reset to 'all' groups
:BusterSetGroupAll
:BusterSetGroup ""
```

More on Buster Groups: http://docs.busterjs.org/en/latest/modules/buster-configuration/

BUSTER TEST EXECUTABLE LOCATION

By default the plugin will use the command `buster test` to execute test runs. For node.js environments Buster works best when tests are executed locally (as in a binary located inside the repository root), rather than the globally installed binary (if it exists). To allow developers to switch between the two (though browsers also work from a local path), the plugin exposes the following variable and methods:

```vim
" In ~/.vimrc
" Tell plugin to run buster locally - assumes buster dependency available
" in ./node_modules folder. Install via npm install --dependencies if need be.
let g:busterlocal="true"   " technically can be any string

" From Vim
:BusterUseLocal
:BusterUseGlobal
```

ISSUES
====================

KEY MAPPINGS IGNORED

I've noticed on rare occasions if running both this vimux pugin and its counterpart for ruby in a long-running Vim session that key mappings sometimes stop working. As far as I can see Vim's file detection gets a little confused so some keymappings are ignored in the JS version, or the keys become mapped to the wrong command for the current filetype. Initiating a fresh Vim instance cleared this up for me.

CONTRIBUTING
====================

Pull requests welcome!

While I have found no way to import external ruby code into Vim, I have used TDD to develop the buffer parsing logic for running the focused tests. If you would like to contribute please add tests to support your patch, and ensure they are passing before sending a pull request. To install the test dependencies `cd` to the repo folder and run `bundler install`. You can use the supplied Guard to autorun the minitest suite.

TODO
===================

- Better testrunner detect - can't issue global run command w/o reference to runner being present
-- Better to follow test runner CLI logic to detect presence (i.e. awk for a buster.js file?)
- Add note about per-dir vimrc files.
- Add support for other popular runners: Jasmine, Mocha, Vows, NodeUnit
- Expose global variable to turn off the auto-clear functionality
- Support for running a parent test/spec context

ACKNOWLEDGEMENTS
====================

Once again to the authors of the vimux-ruby-test plugin for providing a reference implementation to get this plugin started, and of course @benmills for the awesome vimux plugin which facilitates such IDE shenanigans within the terminal. Vim on!

CONTRIBUTORS:
====================

- [Andy Beeching](https://github.com/andybeeching)
