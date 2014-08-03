require 'thor'
load File.dirname(__FILE__) + '/../github_organizations.thor'

describe GithubOrganizations do
  describe '#fetch_data' do
    it 'does it' do
      original_stdout = $stdout
      $stdout = fake = StringIO.new
      GithubOrganizations.new.fetch_data('github', 'something')
      $stdout = original_stdout
      expect(fake.string).to eq "+--------------+----------------------------+---------------+\n|           Github repositories for organizations           |\n+--------------+----------------------------+---------------+\n| organization | repo                       | repo language |\n+--------------+----------------------------+---------------+\n| github       | media                      |               |\n| github       | github-services            | Ruby          |\n| github       | albino                     | Ruby          |\n| github       | hubahuba                   | Ruby          |\n| github       | jquery-hotkeys             |               |\n| github       | jquery-relatize_date       |               |\n| github       | request_timer              | Ruby          |\n| github       | will_paginate_with_hotkeys | Ruby          |\n| github       | gem-builder                | Ruby          |\n| github       | learn.github.com           | CSS           |\n| github       | safegem                    | Ruby          |\n| github       | develop.github.com         | JavaScript    |\n| github       | markup                     | Ruby          |\n| github       | hub                        | Ruby          |\n| github       | upload                     | Ruby          |\n| github       | github-services            | Ruby          |\n| github       | gitcasts                   | CSS           |\n| github       | rails                      | Ruby          |\n| github       | gitignore                  |               |\n| github       | dmca                       |               |\n| github       | pong                       |               |\n| github       | pycon2011                  | Python        |\n| github       | email_reply_parser         | Ruby          |\n| github       | developer.github.com       | Ruby          |\n| github       | linguist                   | Ruby          |\n| github       | ghterm                     | JavaScript    |\n| github       | testrepo                   | C             |\n| github       | gollum                     | JavaScript    |\n| github       | node-statsd                | JavaScript    |\n| github       | maven-plugins              | Java          |\n\n+--------------+----------------------------+---------------+\n"
    end
  end
end
