require 'rubygems'
require 'bundler/setup'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/reporters'
require 'fakefs'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new

require 'kitfile_parser'
