class Breeze::Queries::IndexPage < BreezeLayout
  needs pages : Lucky::Paginator
  needs breeze_queries : BreezeSqlStatementQuery

  def page_title : String
    "All Queries"
  end

  def content
    render_table
  end

  def render_table
    mount Breeze::Panel do
      ul class: "mt-1 divide-y divide-gray-200" do
        breeze_queries.each do |query|
          query_row(query)
        end
      end

      mount Breeze::PageNav, pages
    end
  end

  def query_row(query)
    li do
      link to: Queries::Show.with(query.id), class: "block hover:bg-indigo-50 focus:outline-none focus:bg-gray-50 transition duration-150 ease-in-out" do
        div class: "flex items-center px-4 py-4 sm:px-4" do
          div class: "min-w-0 flex-1 flex items-center" do
            div class: "min-w-0 flex-1 px-4 md:grid md:grid-cols-3 md:gap-6" do
              div query.statement, class: "font-mono text-sm leading-5 col-span-2 text-indigo-700 truncate"
              div class: "hidden sm:block ml-7" do
                div class: "text-sm leading-5 text-gray-500" do
                  text "#{time_ago_in_words(query.created_at)} ago"
                end
              end
            end
          end
          div do
            mount RowArrow
          end
        end
      end
    end
  end
end
