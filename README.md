WHAT?
====================

- Run the test/spec your cursor is currently on
- Run the context your cursor is currently in
- Run the entire test/spec you are working in
- Streaming output to tmux via vimux

This plugin currently supports
  - [buster](http://busterjs.org)

The original idea and 90% of the code is based on the even more useful [vimux-ruby-test
plugin](foo) by ... . I just wanted the same functionality for my buster tests...

HOW?
====================

Use any of the commands below. Map them to shortcuts
in your .vimrc for easy access.

  - RunJavaScriptFocusedTest - run focused test/spec
  - RunJavaScriptFocusedTest - run focused test (no spec support) in a Rails app
  - RunJavaScriptFocusedContext - run current context (rspec, shoulda)
  - RunAllJavaScriptTests - run all the tests/specs in the current file

INSTALL
====================

Put the contents of this directory into your pathogen bundle. That's it!

REQUIREMENTS
====================

- vim with ruby support (compiled +ruby)
- [vimux](https://github.com/benmills/vimux)

ACKNOWLEDGEMENT
====================

Once again to the authors of the vimux-ruby-test plugin for providing an easily
customisable codebase for this plugin, and of course, ???? for the awesome vimux
Vim plugin which facilitates such IDE shenanigans within the terminal. Vim on!

CONTRIBUTORS:
====================

- [Andy Beeching](https://github.com/andybeeching)
