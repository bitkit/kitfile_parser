require 'helper'

describe KitfileParser do
  describe "A filesystem Kitfile" do
    before do
      FileUtils.mkpath(File.expand_path("."))
      File.open File.expand_path("./Kitfile"), 'w' do |f|
        f.write <<eof
heroku/web(3): bundle exec rackup config.ru
  - myapp.com/*
joyent/worker: node worker.js
elastic_mapreduce/indexer: python indexer.py
eof
      end
    end
    it 'gets parsed properly' do
      kitfile = KitfileParser.parse File.read('Kitfile')
      kitfile.nodes.length.must_equal 3
      kitfile.nodes['web'].platform.must_equal :heroku
      kitfile.nodes['web'].initial_concurrency.must_equal 3
      kitfile.nodes['web'].command.must_equal 'bundle exec rackup config.ru'
      kitfile.nodes['web'].routes.length.must_equal 1
      kitfile.nodes['web'].routes.first.must_equal 'myapp.com/*'
      kitfile.nodes['worker'].initial_concurrency.must_equal 0
    end
    after do
      FakeFS::FileSystem.clear
    end
  end
  describe "A Kitfile defined in Ruby code" do
    before do
      @kitfile = KitfileParser::Kitfile.new do |kitfile|
        kitfile.node :heroku, 'web', 'bundle exec rackup config.ru', 3 do |frontend|
          frontend.route 'myapp.com/*'
        end
        kitfile.node :joyent, 'worker', 'node worker.js'
        kitfile.node :elastic_mapreduce, 'indexer', 'python indexer.py'
      end
    end
    it 'gets parsed properly' do
      kitfile = @kitfile
      kitfile.nodes.length.must_equal 3
      kitfile.nodes['web'].platform.must_equal :heroku
      kitfile.nodes['web'].initial_concurrency.must_equal 3
      kitfile.nodes['web'].command.must_equal 'bundle exec rackup config.ru'
      kitfile.nodes['web'].routes.length.must_equal 1
      kitfile.nodes['web'].routes.first.must_equal 'myapp.com/*'
      kitfile.nodes['worker'].initial_concurrency.must_equal 0
    end
  end
end





