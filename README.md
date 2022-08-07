### Requirements
* ruby 3.0.4
* bundler 2.3.18

### Install
```bash
bundle install
```

### Test
```bash
bundle exec rubocop
bundle exec reek
bundle exec rspec
```

### Run
```bash
./parser <file_path>
```

### Output example
```bash
> ./parser.rb ./spec/fixtures/webserver.log
Total visits:
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits

Unique visits:
/help_page/1 23 unique visits
/contact 23 unique visits
/home 23 unique visits
/index 23 unique visits
/about/2 22 unique visits
/about 21 unique visits
```
