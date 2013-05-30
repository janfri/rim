# -- encoding: utf-8 --

# Load ~/.rimrc if it exists
home = if Dir.respond_to? :home
         Dir.home
       else
         # This will hopefully work on *NIX and Windows systems
         ENV['HOME'] || ENV['HOMEDRIVE'] + ENV['HOMEPATH'] || ENV['USERPROFILE']
       end
rimrc = File.join(home, '.rimrc')
if File.exist?(rimrc)
  load rimrc
end

# Load local .rimrc if it exists
rimrc = '.rimrc'
if File.exist?(rimrc)
  load rimrc
end
