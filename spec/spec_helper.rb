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
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS pg_stat_statements;")
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS pg_buffercache;")
    RubyPgExtras.connection.exec("CREATE EXTENSION IF NOT EXISTS sslinfo;")
  end
end
