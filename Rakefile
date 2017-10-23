#!/usr/bin/env rake

task :default => [:test]
task :ci => [:dump, :test]

task :dump do
  sh 'vim --version'
end

task :test do
  sh 'bin/vim-flavor test'
end
