require 'rake/clean'
require 'rake/testtask'

PARSER_FILES = %w[
  pegdown.rb
]

CLEAN.push(*PARSER_FILES)

task :default => [:generate, :test]

task :generate => PARSER_FILES

rule '.rb' => '.kpeg' do |t|
  kpeg = Gem.bin_path 'kpeg', 'kpeg'

  ruby "-rubygems #{kpeg} -fs -o #{t.name} #{t.source}"
  #ruby "-I ../kpeg/lib ../kpeg/bin/kpeg -fs -o #{t.name} #{t.source}"
end

Rake::TestTask.new do |t|
  t.libs << '.'
  t.test_files = FileList['test/test_*']
end

