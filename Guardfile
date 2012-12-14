# More info at https://github.com/guard/guard#readme

notification :growl

guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/test_(.*)\.rb|)
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})  { |m| "test/#{m[1]}test_#{m[2]}.rb" }
end
