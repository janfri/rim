# Rim a super simple ruby project / gem manager

Goal is to have a project managing that just works on many Ruby
versions as possible and is easy to extend. Feel free to dislike it. ;)


## Use for project management

Minimal Rakefile:

```ruby
require 'rim'
require 'rim/gem'
# require 'rim/...'

Rim.setup do
  # set up things of necessary
end
```

For advanced usage have a look at the Rakefile of rim.


## Writing an extension

* Extend the class Rim with <code>attr_accessors</code> for new attributes if needed.
* Set default values use <code>Rim.defaults</code>.
* Define tasks with <code>Rim.after_setup</code>.

A very simple example extension:

```ruby
# require other extensions if necessary

require 'rim/another_extension'

# Extend the class

class Rim
  # Attribute for somewhat (default: 42)
  attr_accessor :my_attr
end

# Setting default values

Rim.defaults do
  my_attr 42
end

# Stuff to execute after setting the defaults and calling Rim.setup in Rakefile.
# Usual for defining tasks.

Rim.after_setup do
  task :my_task => :another_task do
    # stuff
  end
end
```

For more examples have a look at the tasks coming with rim in <code>lib/rim/*.rb</code>


## Similar projects

* https://github.com/seattlerb/hoe
* https://github.com/evan/echoe


## Credits

<em>Jim Weirich</em> For written the great Rake. (Sad that he is already gone.)

<em>Ryan Davis</em> and <em>Evan Weaver</em> For their inspirations in Hoe respectively Echoe.


## License

MIT-style license, see file LICENSE.
