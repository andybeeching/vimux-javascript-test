if exists("g:loaded_vimux_buster") || &cp
  finish
endif
let g:loaded_vimux_buster = 1

if !has("ruby")
  finish
end

command RunAllJavaScriptTests :call s:RunAllJavaScriptTests()
command RunJavaScriptFocusedTest :call s:RunJavaScriptFocusedTest()
command RunJavaScriptFocusedContext :call s:RunJavaScriptFocusedContext()

function s:RunAllJavaScriptTests()
  ruby JavaScriptTest.new.run_all
endfunction

function s:RunJavaScriptFocusedTest()
  ruby JavaScriptTest.new.run_test
endfunction

function s:RunJavaScriptFocusedContext()
  ruby JavaScriptTest.new.run_context
endfunction

" Define some default settings
if !exists("g:bustergroup")
  let g:busterenv = "all"
endif
if !exists("g:buster_test_prefix")
  let g:buster_test_prefix = ""
endif
if !exists("g:buster_spec_prefix")
  let g:buster_spec_prefix = ""
endif

ruby << EOF
# TODO:
# QUESTION: How to read and write Vim variables from ruby?
# Implement runner tester (isBuster?)
# Add support for testCases/Specs (inc. nested)
# Add support for setting group
# Add custom test name prefix/string?
# Add option to not clear previous results (slows loop?)
# Make the script more extensible for other testrunners
# i.e. How to dynamically include/mixin an interface to pick up necessary methods
module VIM
  class Buffer
    def method_missing(method, *args, &block)
      VIM.command "#{method} #{self.name}"
    end
  end
end

class JavaScriptTest
  def current_file
    VIM::Buffer.current.name
  end

  def line_number
    VIM::Buffer.current.line_number
  end

  def buster?
    result = false
    # VIM::Buffer.current is a list *like* object, so no iteration
    # methods directly on the object (afaik)
    1.upto(VIM::Buffer.current.length) do |line_number|
      if VIM::Buffer.current[line_number] =~ /buster/
        result = true
        break;
      end
    end
    result
  end

  # Method to parse a string for a buster test
  # Returns test name or nil
  def parse_buster_test_name(line)
    return if line =~ /setup|teardown|testCase|describe/

    # Branch on test flavour
    if line =~ /it\(/
      # it("yield 0 in score for gutter game", function () {
      parts = line.split("it(")[1].split(",")
    else
      # Test for key:value object member syntax + check for method
      parts = line.split(":")
    end
    return unless parts.length && parts.last =~ /function/

    # Disco!
    parts.pop
    parts.join(":").scan(/([^"|']+)/)
    $1
  end

  def run_unit_test
    method_name = nil
    # parse = parse_buster_test_name if is_buster?

    (line_number).downto(1) do |line_number|
      method_name = parse_buster_test_name(VIM::Buffer.current[line_number])
      break if method_name
    end

    send_to_vimux("buster test --tests #{current_file} '#{method_name}'") if method_name
  end

  def run_test
    run_unit_test
  end

  def run_context
    method_name = nil
    context_line_number = nil

    (line_number + 1).downto(1) do |line_number|
      if VIM::Buffer.current[line_number] =~ /(context|describe) "([^"]+)"/ ||
         VIM::Buffer.current[line_number] =~ /(context|describe) '([^']+)'/
        method_name = $2
        context_line_number = line_number
        break
      end
    end

    if method_name
      method_name = "\"/#{Regexp.escape(method_name)}/\""
      send_to_vimux("ruby #{current_file} -n #{method_name}")
    end
  end

  def run_all
    send_to_vimux("buster test -tests '#{current_file}'")
  end

  def send_to_vimux(test_command)
    Vim.command("call VimuxRunCommand(\"clear && #{test_command}\")")
  end
end
EOF
