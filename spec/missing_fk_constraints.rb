# frozen_string_literal: true

require "spec_helper"
require "ruby-pg-extras"

describe "#missing_fk_constraints" do
  it "detects missing foreign keys for all tables" do
    result = RubyPgExtras.missing_fk_constraints(in_format: :hash)
    expect(result.size).to eq(2)
    expect(result[0]).to eq({
                           table: "users", column_name: "company_id",
                         })
    expect(result[1]).to eq({
                           table: "posts", column_name: "topic_id",
                         })
  end

  it "detects missing foreign_keys for a specific table" do
    result = RubyPgExtras.missing_fk_constraints(args: { table_name: "posts" }, in_format: :hash)

    expect(result.size).to eq(1)
    expect(result[0]).to eq({
      table: "posts", column_name: "topic_id",
    })
  end
end
