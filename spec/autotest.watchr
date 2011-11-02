def test
  system('clear')
  system("make spec")
end

watch('^(bin/(.*))') { |m| test }
watch('^(lib/(.*)\.coffee)') { |m| test }
watch('^(test/(.*)\.coffee)') { |m| test }
watch('^(Makefile)') { |m| test }

test