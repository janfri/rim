Rim.after_setup do
  desc "Release version #{version}"
  task :release do
    if feature_loaded 'rim/gem'
      invoke 'gem:push'
    end
  end
end
