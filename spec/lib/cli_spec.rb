require "spec_helper"

RSpec.describe CLI do
  describe "#parse" do
    let(:args) { ['--source', 'data.csv', '--order_by', 'age', 'desc'] }

    describe "When passing valid args" do
      let(:cli) { CLI.new(args)}

      it "returns a hash with values" do
        expect(cli.parse!).to include({
          :source=>"data.csv",
          :order_by=>["age", "desc"]
        })
      end
    end

    describe "When passing an invalid args" do
      let(:cli) { CLI.new(args)}

      # Passando argumento invávlido `--unknown`
      before { args << '--unknown' }

      it { expect { cli.parse! }.to raise_error Slop::UnknownOption }
    end
  end
end
