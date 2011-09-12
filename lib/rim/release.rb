Rim.after_setup do
  task :release
    desc "Release version #{version}"
    task :release => [:clean, :test] do
      invoke 'gem:push'
    end
end
