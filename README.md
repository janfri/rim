# Rim a super simple ruby project / gem manager

Goal is to have a project managing that just works on many Ruby
versions as possible and is easy to extend. Feel free to dislike it. ;)


## Use for project management

Since rim version 3.0.0 it is necessary to create a gemspec file with the basic
configuration of the project. See [online
documentation](https://guides.rubygems.org/specification-reference/) for more
information. The rest is done in Rakefile.

Example of a minimal Rakefile:

```ruby
require 'rim'
require 'rim/gem'
# require 'rim/...'

Rim.setup do
  # set up things of necessary
end
```

For advanced usage have a look at the Rakefile of rim.


## Upgrading from Rim before version 3.0.0

All accessor methods of configuration which can be defined in the gemspec file
are no longer relevant. Rim emits a warning when such method is called and
<em>does not</em> use those values any longer. It is necessary to set these
values in the gemspec file.


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


## Contribution

The code is also hosted in a git repository at [github](http://github.com/janfri/rim) and [bitbucket](https://bitbucket.org/janfri/rim)

Feel free to contribute!


## Versioning

Rim follows [Semantic Versioning](https://semver.org/), both SemVer and
SemVerTag.


## Author

Jan Friedrich <janfri26@gmail.com>


## License

MIT-style license, see file LICENSE.
