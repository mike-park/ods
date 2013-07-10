require 'spec_helper'

describe Ods::Sheet do
  let(:file) { Ods::File.open(SIMPLE_ODS_FILE) }
  let(:sheets) { file.sheets }

  context "sheet 1" do
    let(:sheet) { sheets.first }

    it { sheet.name.should == 'Sheet1' }

    context "sizes" do
      it { sheet.rows.count.should > 4 }
      it { sheet.rows[0].cols.count.should == 4 }
    end

    context "basic navigation" do
      context "first row" do
        it { sheet[0,0].value.should == 'A' }
        it { sheet[0,0].value.should be_kind_of(String) }
        it "have 4 columns" do
          sheet.rows[0].cols.count.should == 4
        end
        it "contains" do
          %w(A row of strings).each_with_index do |s, i|
            sheet[0, i].value.should == s
          end
        end
      end

      context "second row" do
        (1..4).each do |i|
          it { sheet[1,i-1].value.should == Date.new(2011, 1, i) }
          it { sheet[1,i-1].value.should be_kind_of(Date) }
        end
      end

      context "third row integers" do
        (1..4).each do |i|
          it { sheet[2,i-1].value.should == i }
          it { sheet[2,i-1].value.should be_kind_of(Fixnum) }
        end
      end

      context "forth row matches third row" do
        (1..4).each do |i|
          it { sheet[3,i-1].value.should == i }
          it { sheet[3,i-1].value.should be_kind_of(Fixnum) }
        end
      end

      context "row five has mixed float&ints" do
        it { sheet[4,0].value.should == 0 }
        it { sheet[4,0].value.should be_kind_of(Fixnum) }

        it { sheet[4,1].value.should == -1.1 }
        it { sheet[4,1].value.should be_kind_of(Float) }

        it { sheet[4,2].value.should == 2.2 }
        it { sheet[4,2].value.should be_kind_of(Float) }

        it { sheet[4,3].value.should == 3 }
        it { sheet[4,3].value.should be_kind_of(Fixnum) }
      end

      context "row 6 has booleans" do
        it { sheet[5,0].value.should == true }
        it { sheet[5,0].value.should be_kind_of(TrueClass) }

        it { sheet[5,1].value.should == false }
        it { sheet[5,1].value.should be_kind_of(FalseClass) }
      end

      context "out of bounds" do
        it { sheet[1000,100].should_not be }
      end
    end
  end

  context "sheet 2" do
    let(:sheet) { sheets[1] }

    it { sheet.name.should == "Sheet2" }

    context "column A" do
      (0..9).each do |row|
        context "row #{row}" do
          it { sheet[row, 0].value.should == "A#{row+1}" }
        end
      end

      it { sheet[10,0].should_not be }
    end

    context "bottom right" do
      it { sheet[9, 3].value.should == 'D10' }
    end
  end
end
