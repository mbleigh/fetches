Gem::Specification.new do |s|
  s.name = "fetches"
  s.version = "0.0.3"
  s.date = "2008-07-28"
  s.summary = "Rails plugin for simplified parameter-based model fetching."
  s.email = "michael@intridea.com"
  s.homepage = "http://www.actsascommunity.com/projects/fetches"
  s.description = "Rails plugin for simplified parameter-based model fetching."
  s.has_rdoc = true
  s.authors = ["Michael Bleigh"]
  s.files = [ "MIT-LICENSE",
              "README",
              "Rakefile",
              "lib/fetches.rb",
              "lib/action_controller/fetches.rb",
              "rails/init.rb",
              "test/fetcher_test_helper.rb",
              "test/fetches_test.rb" ]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README", "MIT-LICENSE"]
end