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

  # Add this line here
  require "breeze/tasks"

  LuckyTask::Runner.run
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

## Configuration

You breeze configuration will be located in `config/breeze.cr`. This file was added for you when you ran `lucky breeze.install`.

```crystal
# config/breeze.cr

Breeze.configure do |settings|
  # The database to store the request info
  settings.database = AppDatabase

  # Enable Breeze only for this environment
  settings.enabled = Lucky::Env.development?
end

# Configuration settings for Actions
Breeze::ActionHelpers.configure do |settings|
  # This setting is optional
  settings.skip_pipes_if = ->(context : HTTP::Server::Context) {
    context.request.resource.starts_with?("/admin")
  }
end
```

* `database` - This is the `Avram::Database` your models inherit from. By default, it's `AppDatabase`.
* `enabled` - When set to `false`, you won't be able to visit any of the breeze pages. This is enabled for development by default.
* `skip_pipes_if` - Breeze will store the request and response for every action in your app. If there's some actions you don't want to store, you can skip these by matching the request path or resource. You could also skip certain content types, or whatever else you want.

## Breeze Extensions

Breeze comes with a [Carbon](https://github.com/luckyframework/carbon) extension that allows you to preview your emails right in the browser.

### Installing

1. Add the require to your `src/shards.cr` right below your `require "breeze"`:

    ```crystal
   require "breeze"
   require "breeze/extensions/carbon"
   ```

2. Add your Email preview class to `src/emails/previews.cr`:

   ```crystal
   class Emails::Previews < Carbon::EmailPreviews
     def previews : Hash(String, Carbon::Email)
       {
         "welcome_email"  => WelcomeEmail.new(UserQuery.first),
         "password_reset" => PasswordResetRequestEmail.new(UserQuery.first),
       } of String => Carbon::Email
     end
   end
   ```

3. Update your Breeze config in `config/breeze.cr`:

   ```crystal
   Breeze.configure do |settings|
     # ... other settings
     
     # Set this to the name of your preview class
     settings.email_previews = Emails::Previews
   end
   ```
   
### Usage

Just visit `/breeze/emails` in your browser, and you'll see your emails. Click the `HTML` button to see the HTML version of your email, or the `TEXT` to see the plain text version.

### Configuration

By enabling this extension, Breeze will require a new setting `email_previews` which is the class that will contain your preview setup. This is so Breeze knows what you named the class.

Your email preview class should inherit from `Carbon::EmailPreviews`, and define an instance method `previews` which returns a `Hash(String, Carbon::Email)`. The `String` key is a key that will be passed through the URL to locate which email Breeze will display. The value will be an instance of the `Carbon::Email` to be rendered. Since each email requires different arguments in order to be instantiated, it's up to you to define how those values are set.

## Extending Breeze

coming soon....


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
