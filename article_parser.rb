# frozen_string_literal: true

# ArticleParser allows to input a json of an article and return articles.
# It will need to have the following functions (in order of priority):
# Step 1. Return an article with a published date /
# Step 2. Allow to get a title (the first hl1) from an article /
# Step 3. Allow to retrieve the raw json body of the article (eventually to be used by clients) /
# Step 4. Be able to retrieve a brief summary in the article (defined by title + first paragraph) /

# Note:
# We don't expect strict types to be returned. Choose what you think that fits here.
require 'json'

class ArticleParser
  HTML_TAGS = %w(hl1 p)

  def initialize(article)
    @article = JSON.parse(article)
  end

  def get_article_with_published_date
    {  article: get_article.compact, published_date: @article["published_at"] }
  end

  def get_article_title
   title = @article["body"].select { |article| article["type"] == 'hl1' }.first

   title["content"]
  end

  def get_raw_json_body_of_article
    @article["body"]
  end

  def get_breif_summary_of_article
    paragraph = @article["body"].select { |article| article["type"] == 'p' }.first

    "#{get_article_title}\n#{paragraph["content"]}"
  end

private

  def get_article
    article = @article["body"]

    article.map do |content|
      format_content(content)
    end
  end

  ## I have added this basic formater method to create web app ready HTML, which can then be spat into an html file.
  ## I have used Contentful before which when implemented in a project, enforces something similar to this.
  ## Here is a reference to work I have done at a previous role, relating to parsing content and presenting it on a webpage
  ## https://github.com/ministryofjustice/hmpps-book-secure-move-frontend/blob/main/common/services/contentful.ts
  def format_content(content)
    html_tag = content["type"]
    text = content["content"]

    "<#{html_tag}>#{text}</#{html_tag}>" if HTML_TAGS.include?(html_tag)
  end
end
