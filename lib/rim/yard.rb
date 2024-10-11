# encoding: utf-8
CLEAN.include(FileList['.yardoc'].existing)
CLOBBER.include(FileList['doc'].existing)
task :yard do
  sh 'yard'
end
