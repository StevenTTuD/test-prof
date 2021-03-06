# frozen_string_literal: true

if ActiveRecord::VERSION::MAJOR < 4
  require "test_prof/ext/active_record_3"
  using TestProf::ActiveRecord3Transactions
end

shared_context "transactional", transactional: true do
  prepend_before(:each) do
    ActiveRecord::Base.connection.begin_transaction(joinable: false)
  end

  append_after(:each) do
    ActiveRecord::Base.connection.rollback_transaction
  end
end
