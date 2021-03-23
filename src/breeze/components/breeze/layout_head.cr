class Breeze::LayoutHead < Breeze::BreezeComponent
  needs page_title : String
  # This is used by the 'csrf_meta_tags' method
  needs context : HTTP::Server::Context

  def render
    head do
      utf8_charset
      title "Breeze - #{page_title}"
      css_link "https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css"
      css_link "https://rsms.me/inter/inter.css"
      js_link "https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.0.1/dist/alpine.js", defer: "true"
      meta name: "turbolinks-cache-control", content: "no-cache"
      csrf_meta_tags
      responsive_meta_tag
    end
  end
end
