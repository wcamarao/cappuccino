def test
  system('clear')
  system("make test")
end

watch('^(lib/(.*)\.coffee)') { |m| test }
watch('^(test/(.*)\.coffee)') { |m| test }
watch('^(Makefile)') { |m| test }

test