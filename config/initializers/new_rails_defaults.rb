# Be sure to restart your server when you modify this file.

# These settings change the behavior of Rails 2 apps and will be defaults
# for Rails 3. You can remove this initializer when Rails 3 is released.

if defined?(ActiveRecord)
  # Include Active Record class name as root for JSON serialized output.
  ActiveRecord::Base.include_root_in_json = false                               #默认为true，不让他自己增加方括号

  # Store the full class name (including module namespace) in STI type column.
  ActiveRecord::Base.store_full_sti_class = true

  ActiveRecord::Base.partial_updates = true                                     #单独添加
end

#  ActionController::Routing.generate_best_match = false

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = false                             #默认为true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper.
# if you're including raw json in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

