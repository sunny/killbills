require 'sass/plugin'

# FIXME needs to be different in production and development

# Sets the style of the CSS output. Can be nested, expanded, compact or compressed.
Sass::Plugin.options[:style] = :nested

# Whether parsed Sass files should be cached, allowing greater speed. Defaults to true.
#Sass::Plugin.options[:cache] = false


# Whether the CSS files should never be updated, even if the template file changes. Setting this to true may give small performance gains. It always defaults to false. Only has meaning within Rack, Ruby on Rails, or Merb.
#Sass::Plugin.options[:never_update] = true


# Whether the CSS files should be updated every time a controller is accessed, as opposed to only when the template has been modified. Defaults to false. Only has meaning within Rack, Ruby on Rails, or Merb.
#Sass::Plugin.options[:always_update] = true

# Whether a Sass template should be checked for updates every time a controller is accessed, as opposed to only when the server starts. If a Sass template has been updated, it will be recompiled and will overwrite the corresponding CSS file. Defaults to false in production mode, true otherwise. Only has meaning within Rack, Ruby on Rails, or Merb.
Sass::Plugin.options[:always_check] = true


# Whether an error in the Sass code should cause Sass to provide a detailed description within the generated CSS file. If set to true, the error will be displayed along with a line number and source snippet both as a comment in the CSS file and at the top of the page (in supported browsers). Otherwise, an exception will be raised in the Ruby code. Defaults to false in production mode, true otherwise. Only has meaning within Rack, Ruby on Rails, or Merb.
Sass::Plugin.options[:full_exception] = true

# When set to true, causes the line number and file where a selector is defined to be emitted into the compiled CSS as a comment. Useful for debugging, especially when using imports and mixins. This option may also be called :line_comments. Automatically disabled when using the :compressed output style or the :debug_info/:trace_selectors options.
#Sass::Plugin.options[:line_numbers] = true

# When set to true, emit a full trace of imports and mixins before each selector. This can be helpful for in-browser debugging of stylesheet imports and mixin includes. This option supersedes the :line_comments option and is superseded by the :debug_info option. Automatically disabled when using the :compressed output style.
#Sass::Plugin.options[:trace_selectors] = true

# When set to true, causes the line number and file where a selector is defined to be emitted into the compiled CSS in a format that can be understood by the browser. Useful in conjunction with the FireSass Firebug extension for displaying the Sass filename and line number. Automatically disabled when using the :compressed output style.
Sass::Plugin.options[:debug_info] = true


# When set to true, causes warnings to be disabled.
#Sass::Plugin.options[:quiet] = true

