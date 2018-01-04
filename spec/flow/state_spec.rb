# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stealth::Flow::State do

  class NewTodoFlow
    include Stealth::Flow

    flow do
      state :new

      state :get_due_date

      state :created, fails_to: :new

      state :error
    end
  end

  let(:flow) { NewTodoFlow.new }

  describe "flow states" do
    it "should convert itself to a string" do
      expect(flow.current_state.to_s).to be_a(String)
    end

    it "should convert itself to a symbol" do
      expect(flow.current_state.to_sym).to be_a(Symbol)
    end
  end

  describe "fails_to" do
    it "should be nil for a state that has not specified a fails_to" do
      expect(flow.current_state.fails_to).to be_nil
    end

    it "should return the fail_state if a fails_to was specified" do
      flow.init_state(:created)
      expect(flow.current_state.fails_to).to be_a(Stealth::Flow::State)
      expect(flow.current_state.fails_to).to eq :new
    end
  end

end