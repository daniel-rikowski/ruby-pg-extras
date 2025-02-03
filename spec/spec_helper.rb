# frozen_string_literal: true

require "rubygems"
require "bundler/setup"
require_relative "../lib/ruby-pg-extras"

pg_version = ENV["PG_VERSION"]

PG_PORTS = {
  "12" => "5432",
  "13" => "5433",
  "14" => "5434",
  "15" => "5435",
  "16" => "5436",
  "17" => "5437",
}

port = PG_PORTS.fetch(pg_version, "5432")

ENV["DATABASE_URL"] ||= "postgresql://postgres:secret@localhost:#{port}/ruby-pg-extras-test"

RSpec.configure do |config|
  config.before(:suite) do
    DB_SCHEMA = <<-SQL
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS companies;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255),
    company_id INTEGER
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    topic_id INTEGER,
    external_id INTEGER,
    title VARCHAR(255),
    CONSTRAINT fk_posts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255)
);

CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE INDEX index_posts_on_user_id ON posts(user_id, topic_id);
SQL

    RubyPgExtras.connection.exec(DB_SCHEMA)
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS pg_stat_statements;")
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS pg_buffercache;")
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS sslinfo;")
  end
end
