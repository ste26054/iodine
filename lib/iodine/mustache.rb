module Iodine
  # Iodine includes a safe and fast Mustache templating engine.
  #
  # The engine is also faster and simpler than the official and feature richer Ruby engine.
  #
  # Note: {Iodine::Mustache} behaves differently than the official Ruby templating engine in a number of ways:
  #
  # * When a partial template can't be found, a `LoadError` exception is raised (the official implementation outputs an empty String).
  #
  # * HTML escaping is more agressive, increasing XSS protection. Read why at: https://wonko.com/post/html-escaping .
  #
  # * Partial template padding in Iodine is adds padding to dynamic text as well as static text. i.e., unlike the official Ruby mustache engine, if an argument contains a new line marker, the new line will be padded to match the partial template padding.
  #
  # * Lambda support is significantly different. For example, the resulting text isn't parsed (no lambda interpolation).
  #
  # * Dot notation is tested in whole as well as in part (i.e. `user.name.first` will be tested as is, than the couplet `"user","name.first"` and than as each `"use","name","first"`), allowing for the Hash data to contain keys with dots while still supporting dot notation shortcuts.
  #
  # * Dot notation supports method names (even chained method names) as long as they don't have or require arguments. For example, `user.class.to_s` will behave differently on Iodine (returns `"String"`) than on the official mustache engine (returns empty string).
  #
  # Iodine Mustache's engine was designed to play best with basic data structures, such as results from the {Iodine::JSON} parser.
  #
  # Hash data is tested for String keys before being tested for Symbol keys and methods. This means that `"key"` has precedence over `:key`.
  #
  # Note: Although using methods as "keys" (or argument names) is supported, no Ruby code is evaluated.
  #
  # You can benchmark the Iodine Mustache performance and decide if you wish to switch from the Ruby implementation.
  #
  #     require 'benchmark/ips'
  #     require 'mustache'
  #     require 'iodine'
  #
  #     def benchmark_mustache
  #       # benchmark code was copied, in part, from:
  #       #   https://github.com/mustache/mustache/blob/master/benchmarks/render_collection_benchmark.rb
  #       template = """
  #       {{#products}}
  #         <div class='product_brick'>
  #           <div class='container'>
  #             <div class='element'>
  #               <img src='images/{{image}}' class='product_miniature' />
  #             </div>
  #             <div class='element description'>
  #               <a href={{url}} class='product_name block bold'>
  #                 {{external_index}}
  #               </a>
  #             </div>
  #           </div>
  #         </div>
  #       {{/products}}
  #       """
  #
  #       IO.write "test_template.mustache", template
  #       filename = "test_template.mustache"
  #
  #       data_1 = {
  #         products: [ {
  #           :external_index=>"This <product> should've been \"properly\" escaped.",
  #           :url=>"/products/7",
  #           :image=>"products/product.jpg"
  #         } ]
  #       }
  #       data_1000 = {
  #         products: []
  #       }
  #
  #       1000.times do
  #         data_1000[:products] << {
  #           :external_index=>"product",
  #           :url=>"/products/7",
  #           :image=>"products/product.jpg"
  #         }
  #       end
  #
  #       data_1000_escaped = {
  #         products: []
  #       }
  #
  #       1000.times do
  #         data_1000_escaped[:products] << {
  #           :external_index=>"This <product> should've been \"properly\" escaped.",
  #           :url=>"/products/7",
  #           :image=>"products/product.jpg"
  #         }
  #       end
  #
  #       view = Mustache.new
  #       view.template = template
  #       view.render # Call render once so the template will be compiled
  #       iodine_view = Iodine::Mustache.new(filename)
  #
  #       puts "Ruby Mustache rendering (and HTML escaping) results in:",
  #            view.render(data_1), "",
  #            "Notice that Iodine::Mustache rendering (and HTML escaping) results in agressive escaping:",
  #            iodine_view.render(data_1), "", "----"
  #
  #       # return;
  #
  #       Benchmark.ips do |x|
  #         x.report("Ruby Mustache render list of 1000") do |times|
  #           view.render(data_1000)
  #         end
  #         x.report("Iodine::Mustache render list of 1000") do |times|
  #           iodine_view.render(data_1000)
  #         end
  #
  #         x.report("Ruby Mustache render list of 1000 with escaped data") do |times|
  #           view.render(data_1000_escaped)
  #         end
  #         x.report("Iodine::Mustache render list of 1000 with escaped data") do |times|
  #           iodine_view.render(data_1000_escaped)
  #         end
  #
  #         x.report("Ruby Mustache - no caching - render list of 1000") do |times|
  #           tmp = Mustache.new
  #           tmp.template = template
  #           tmp.render(data_1000)
  #         end
  #         x.report("Iodine::Mustache - no caching - render list of 1000") do |times|
  #           Iodine::Mustache.render(nil, data_1000, template)
  #         end
  #       end
  #       nil
  #     end
  #
  #     benchmark_mustache
  class Mustache
  end
end
