# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "standard/rake"

task default: %i[test standard]

task :console do
  require "irb"
  require "mayan"
  ARGV.clear
  IRB.start
end
