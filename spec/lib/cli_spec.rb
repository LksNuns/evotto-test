require "spec_helper"

RSpec.describe CLI do
  describe "#parse" do
    let(:args) { ['--source', 'data.csv', '--order_by', 'age', 'desc'] }
    let(:cli) { CLI.new(args)}

    describe "When passing valid args" do
      it "returns a hash with values" do
        expect(cli.parse!).to include({
          source: "data.csv",
          option: { method: :order_by, args: ["age", "desc"] }
        })
      end
    end

    describe "When passing many options" do
      # Passando --order_by e --find
      let(:args) { ['--source', 'data.csv', '--order_by', 'age', 'desc', '--find', 'john'] }

      it "raise an error" do
        expect{ cli.parse! }.to raise_error ArgumentError
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
