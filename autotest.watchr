def test
  system('clear')
  system("make test")
end

watch('^(test/(.*)\.coffee)') { |m| test }
watch('^(Makefile)') { |m| test }

test