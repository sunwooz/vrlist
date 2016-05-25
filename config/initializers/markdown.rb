MarkdownRails.configure do |config|

  # See https://github.com/vmg/redcarpet for options.
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
    :tables => true,
    :autolink => true
  )

  config.render do |markdown_source|
    markdown.render markdown_source
  end
end