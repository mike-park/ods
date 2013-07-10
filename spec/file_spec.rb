require 'spec_helper'

describe Ods::File do
  it "should have 3 sheets" do
    ods_file = Ods::File.open(SIMPLE_ODS_FILE)
    expect(ods_file.sheets).to have_exactly(3).items
  end
end
