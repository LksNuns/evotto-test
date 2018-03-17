require 'spec_helper'

RSpec.describe Output::User do
    let(:klass) { Object.new.extend(Output::User) }

  describe '.show_total' do
    it "Prints total on stdout" do
      expect {
        klass.show_total(label: 'Total', total: 10)
      }.to output(/Total: 10/).to_stdout
    end
  end

  describe '.show' do
    describe "When has users" do
      let(:users) { [{ name: 'user', age: 22, project_count: 12, total_value: 10 }] }

      it "Prints a list of users" do
        expect {
          klass.show(users)
        }.to output(/user | 22 | 12 | 10/).to_stdout
      end
    end

    describe "When hasn't users" do
      let(:users) { [] }

      it "Prints an feedback message" do
        expect {
          klass.show(users)
        }.to output(/Nenhum usuário encontrado./).to_stdout
      end
    end
  end

  describe '.show_empty_msg' do
    it "Prints a feedback message" do
      expect {
        klass.show_empty_msg
      }.to output(/Nenhum usuário encontrado/).to_stdout
    end
  end
end
