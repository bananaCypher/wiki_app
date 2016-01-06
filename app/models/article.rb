class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  def html
    renderer = Redcarpet::Render::HTML.new(render_options = {filter_html: true})
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown.render(self.content).html_safe
  end

  private
end
