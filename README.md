# 💨 Breeze

Breeze is a development dashboard for [Lucky Framework](https://luckyframework.org/) that helps you to debug and fine-tune your application.

## Screenshots

| Easy debug logs | View your app requests |
|-----------------|-----------------|
| <img src="https://drive.google.com/uc?id=1K6SEJVzzx-DDfPz6LOX-9X72c-NMgtAf" width="300" /> | <img src="https://drive.google.com/uc?id=1uUlq8kGyIcf_Ug6_7ScA8oL6xQlUDrGd" width="300" /> |

| Overview of a request | See queries |
|-----------------------|-------------|
| <img src="https://drive.google.com/uc?id=1oGFpbM5HbXgDkY92-TNA8zV6pePuH_yL" width="300" /> | <img src="https://drive.google.com/uc?id=1RV5nQoIoHPULjeCXsS2kHkCxn8BLYs6c" width="300" /> |

| Create extensions | Preview emails |
|-------------------|----------------|
| <img src="https://drive.google.com/uc?id=1_dXug1TLn8R01Ky2SD_69m4EqmK4gLeq" width="300" /> | <img src="https://drive.google.com/uc?id=1NXPIRLv9BAFpw6YAOFVqyuZU_w_eYHfJ" width="300" /> |


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
require "./src/app"
require "lucky_task"

# Add this line here
require "breeze/tasks"

#...
LuckyTask::Runner.run
```
5. Add the spec helpers to your `spec/spec_helper.cr`:
```crystal
require "spec"
require "lucky_flow"
require "../src/app"
# ...
require "breeze/spec_helpers"

require "./setup/**"
```
6. Run `lucky breeze.install`
7. Run `lucky db.migrate`

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
  settings.enabled = LuckyEnv.development?
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

If you develop a Breeze extension, let us know and we will list it here!

### Installing BreezeCarbon

1. Add the require to your `src/shards.cr` right below your `require "breeze"`:
```crystal
require "breeze"
require "breeze/extensions/breeze_carbon"
```
2. Add your Email preview class to `src/emails/previews.cr`:
```crystal
class Emails::Previews < Carbon::EmailPreviews
  def previews : Array(Carbon::Email)
    [
      WelcomeEmail.new(UserQuery.first),
      PasswordResetRequestEmail.new(UserQuery.first),
    ] of Carbon::Email
  end
end
```
3. Add the `BreezeCarbon` config to `config/breeze.cr`:
```crystal
BreezeCarbon.configure do |settings|

  # Set this to the name of your preview class
  settings.email_previews = Emails::Previews
end
Breeze.register BreezeCarbon
```

### Using BreezeCarbon

Just visit `/breeze/emails` in your browser, and you'll see your emails. Click the `HTML` button to see the HTML version of your email, or the `TEXT` to see the plain text version.

### Configuring BreezeCarbon

`BreezeCarbon` requires setting the `email_previews` setting to the name of your email preview class.
Your email preview class should inherit from `Carbon::EmailPreviews`, and define an instance method `previews` which returns an `Array(Carbon::Email)`.


## Extending Breeze

1. Create your new extension module (e.g. `module MyBreezeExt`), and add `extend Breeze::Extension`
2. Define your navbar link method in your module:
```crystal
def self.navbar_link : Breeze::NavbarLink
  Breeze::NavbarLink.new(
    link_text: "Breeze Ext",
    link_to: MyBreezeExt::Index.path
  )
end
```
3. Create your actions, and pages like a standard Lucky app. Actions inherit from `Breeze::BreezeAction`. Pages inherit from `Breeze::BreezeLayout`.
4. Lucky apps that include Breeze and your extension will need to add `Breeze.register MyBreezeExt`.

For more examples on creating a Breeze extension, look at the `BreezeCarbon` extension in `src/extensions/breeze_carbon.cr`

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
