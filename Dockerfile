# Wybieramy starą wersję Ruby
FROM ruby:2.6

# Instalujemy zależności systemowe
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

# Ustawiamy katalog roboczy
WORKDIR /app

# Kopiujemy pliki aplikacji
COPY . .

# Instalujemy Bundlera w wersji kompatybilnej z Rails 4.2.11.3
RUN gem install bundler -v 1.17.3

# Instalujemy zależności projektu
RUN bundle update rails
RUN bundle update json
RUN bundle install

# Otwieramy port aplikacji
EXPOSE 3000

# Uruchamiamy serwer Rails
# CMD ["sh", "-c", "bin/rake db:migrate && bundle exec rails server -b 127.0.0.1"]
CMD ["sh", "-c", "bundle exec rails server -b 127.0.0.1"]
