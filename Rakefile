require "bundler"
require "rake/testtask"

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:minitest) do |t|
  t.pattern = "test/unit/*.rb"
  t.verbose = true
end

require "rake/clean"

task test: ["minitest"]

task default: :test
