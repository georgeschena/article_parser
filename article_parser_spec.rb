# frozen_string_literal: true

require_relative 'article_parser'

describe ArticleParser do
  let(:fixture_data) { File.read('fixtures/article.json') }

  subject(:parser) { ArticleParser.new(fixture_data) }

  it 'returns an article with a published date' do
    expect(subject.get_article_with_published_date[:published_date]).to eq('2018-01-03T16:00:09Z')
    expect(subject.get_article_with_published_date[:article]).to eq(
      ["<hl1>Et id consequuntur et qui.</hl1>",
      "<p>Libero ab quo omnis ea ut ea. Rerum vel aspernatur quidem nesciunt debitis sit consequatur. Consectetur vel nesciunt iure et accusamus qui. Autem est blanditiis illum corrupti consequatur eos. Rerum magni voluptas sed ea.</p>",
      "<p>Eos odio ad deserunt voluptatum veniam aut quam qui. Totam ratione adipisci esse praesentium voluptates vel ea. Adipisci ab est dignissimos aut ea. Consequatur molestias culpa fuga qui possimus eius vitae aut. Dignissimos vel rem a assumenda.</p>",
      "<p>Deserunt optio debitis ratione nesciunt. Quo ea ut vel consequatur in hic dolorem. Tenetur quia dolores ab animi.</p>",
      "<hl1>Consequatur in hic dolorem. Tenetur quia dolores ab.</hl1>",
      "<p>Sint necessitatibus sit molestiae deserunt magni neque magnam aperiam. Accusantium et dignissimos ratione labore voluptas. Rem dolor inventore vitae vel eos aliquid.</p>"]
    )
  end

  it 'returns the title of an article' do
    expect(subject.get_article_title).to eq('Et id consequuntur et qui.')
  end

  it 'returns the raw jsob BODY of the article' do
    expect(subject.get_raw_json_body_of_article).to eq([
      {"type"=>"hl1", "content"=>"Et id consequuntur et qui."},
      {"type"=>"p",
        "content"=>
        "Libero ab quo omnis ea ut ea. Rerum vel aspernatur quidem nesciunt debitis sit consequatur. Consectetur vel nesciunt iure et accusamus qui. Autem est blanditiis illum corrupti consequatur eos. Rerum magni voluptas sed ea."},
      {"type"=>"p",
        "content"=>
        "Eos odio ad deserunt voluptatum veniam aut quam qui. Totam ratione adipisci esse praesentium voluptates vel ea. Adipisci ab est dignissimos aut ea. Consequatur molestias culpa fuga qui possimus eius vitae aut. Dignissimos vel rem a assumenda."},
      {"type"=>"p",
        "content"=>
        "Deserunt optio debitis ratione nesciunt. Quo ea ut vel consequatur in hic dolorem. Tenetur quia dolores ab animi."},
      {"type"=>"hl1",
        "content"=>"Consequatur in hic dolorem. Tenetur quia dolores ab."},
      {"type"=>"p",
        "content"=>
        "Sint necessitatibus sit molestiae deserunt magni neque magnam aperiam. Accusantium et dignissimos ratione labore voluptas. Rem dolor inventore vitae vel eos aliquid."}
      ]
    )
  end

  it 'returns a brief summary in the article' do
    expect(subject.get_breif_summary_of_article).to eq('Et id consequuntur et qui.
Libero ab quo omnis ea ut ea. Rerum vel aspernatur quidem nesciunt debitis sit consequatur. Consectetur vel nesciunt iure et accusamus qui. Autem est blanditiis illum corrupti consequatur eos. Rerum magni voluptas sed ea.')
  end

end
