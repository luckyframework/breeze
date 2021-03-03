# 💨 Breeze

Breeze is a development dashboard for [Lucky Framework](https://luckyframework.org/) that helps you to debug and fine-tune your application.

🚧 ** UNDER CONSTRUCTION - Things may change without notice ** 🚧

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     breeze:
       github: luckyframework/breeze
   ```

2. Run `shards install`
3. Add the require to your `src/shards.cr`:

   ```crystal
   require "avram"
   require "lucky"
   # ...
   # Add this line here
   require "breeze"
   ```

4. Add the tasks to your `tasks.cr`:

  ```crystal
  # ...

  # Add these lines here
  require "breeze/tasks/**"
  require "breeze/db/migrations/**"

  LuckyCli::Runner.run
  ```

5. Run `lucky breeze.install`

6. Run `lucky db.migrate`

## Usage

Boot your app locally (`lucky dev`), then open your app in the browser and start using your app.
When you're ready to check out Breeze, look at your development log. You'll see logs similar to this:

```
▸ Debug at http://localhost:5000/breeze/requests/6
```

You can visit a specific request, or just go to `/breeze/requests` to browse.

### Extending Breeze

coming soon.... (ish)


## Development

Install shards `shards install`, and start making changes. Be sure to run `./bin/ameba`, and the crystal formatter `crystal tool format spec src`.

Read through the issues for things you can work on. If you have an idea, feel free to open a new issue!

## Contributing

1. Fork it (<https://github.com/luckyframework/breeze/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jeremy Woertink](https://github.com/jwoertink) - creator and maintainer
