# frozen_string_literal: true

require 'spec_helper'

describe RubyPGExtras do
  RubyPGExtras::QUERIES.each do |query_name|
    it "#{query_name} description can be read" do
      expect do
        RubyPGExtras.description_for(
          query_name: query_name
        )
      end.not_to raise_error
    end
  end

  RubyPGExtras::QUERIES.each do |query_name|
    it "#{query_name} query can be executed" do
      expect do
        RubyPGExtras.run_query(
          query_name: query_name,
          in_format: :hash
        )
      end.not_to raise_error
    end
  end

  describe "#database_url=" do
    it "setting custom database URL works" do
      RubyPGExtras.database_url = ENV.fetch("DATABASE_URL")
      expect do
        RubyPGExtras.bloat(in_format: :hash)
      end.not_to raise_error
    end
  end
end
