When /I run `(.*)`/ do |command|
  @output = `#{command}`
end
Then("the output should contain:") do |string|
  @output.include? string
end
