require "spec_helper"

RSpec.describe Application do
  let(:application) { Application.new }

  describe "#start" do

  end

  describe "#filter_user_with_option" do
    context "When has data" do
      before do
        User.dataset.destroy
        User.create(name: 'One', age: 23)

        # Mockando métodos já testados em Output::User
        # para evitar testes com output
        allow(application).to receive(:show_total).and_return(:show_total)
        allow(application).to receive(:show).and_return(:show)
      end

      describe "when passing --total option" do
        let!(:opt) { { method: :total, args: :age } }
        subject(:filter_user) { application.filter_user_with_option(opt) }

        it { is_expected.to eq :show_total }

        describe "and have no data" do
          before do
            User.dataset.destroy
            allow(application).to receive(:show_empty_msg).and_return(:show_empty_msg)
          end

          it { is_expected.to eq :show_empty_msg }
        end
      end

      describe "when passing --order_by option" do
        let!(:opt) { { method: :order_by, args: [:age, :desc] } }
        subject(:filter_user) { application.filter_user_with_option(opt) }

        it { is_expected.to eq :show }
      end

      describe "when passing --find option" do
        let!(:opt) { { method: :find, args: "name" } }
        subject(:filter_user) { application.filter_user_with_option(opt) }

        it { is_expected.to eq :show }
      end
    end
  end
end
