# Jekyll::PlantumlHook

Render PlantUML in jekyll.

## Installation

First of all, determine a parser gem to use. jekyll-plantuml_hook supports [nokogiri](https://rubygems.org/gems/nokogiri) and [oga](https://rubygems.org/gems/oga), but you have to add it into your application.

Note that you may have already one of them from other gems' dependencices. Check out your `Gemfile.lock`.

Then add jekyll-plantuml_hook to your application.

```ruby
group :jekyll_plugins do
  gem 'jekyll-plantuml_hook', git: 'https://github.com/chulkilee/jekyll-plantuml_hook.git', ref: 'master'
end
```

Add configuration to `_config.yml`.

```yaml
plantuml_hook:
  parser: nokogiri # or oga

  # to render with plantuml server
  plantuml_url: www.plantuml.com/plantuml

  # to render with jar
  plantuml_jar_path: plantuml.jar
```

## Usage

Put plantuml code in code block as `plantuml`.

    ```plantuml
    @startuml
    Bob -> Alice : hello
    @enduml
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chulkilee/jekyll-plantuml_hook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll::PlantumlHook project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
