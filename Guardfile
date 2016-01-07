guard :rspec, cmd: "bundle exec rspec --color --format documentation" do
  watch(/^recipes\/(.+)\.rb$/) { "spec" }
  watch(/^spec\/(.+)\.rb$/) { "spec" }
end
