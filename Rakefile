require 'rake/clean'

PARSER_FILES = %w[
  pegdown.rb
]

CLEAN.push(*PARSER_FILES)

task :default => :generate

task :generate => PARSER_FILES

rule '.rb' => '.kpeg' do |t|
  kpeg = Gem.bin_path 'kpeg', 'kpeg'

  name = File.basename t.source, '.kpeg'
  name = name.capitalize
  name = name.gsub(/_(.)/) { "_#{$1.upcase}" }

  ruby "-rubygems #{kpeg} -fs -n #{name} -o #{t.name} #{t.source}"
end

