require 'spec_helper'

RSpec.describe User do
  before do
    User.dataset.destroy
    %w[Paulo Zalito João Afonso].each do |name|
      User.create(name: name, age: 20)
    end 
  end

  describe '.find' do
    subject(:result) { User.find('afonso') }

    it { expect(result.count).to be 1 }
    it { expect(result.first[:name]).to eq "Afonso" }
  end

  describe '.total' do
    subject(:result) { User.total(:age) }

    it { is_expected.to be 80 }
    
    describe "when have no data" do
      before { User.dataset.destroy }
      
      it { is_expected.to be nil }
    end
  end
  
  describe '.order_by' do
    describe "When search with DESC direction" do
      subject(:result) { User.order_by(:name, :desc) }
      
      it { expect(result.last[:name]).to  eq "Afonso" }
      it { expect(result.first[:name]).to eq "Zalito" }
    end

    describe "When search with ASC direction" do
      subject(:result) { User.order_by(:name, :asc) }
      
      it { expect(result.first[:name]).to eq "Afonso" }
      it { expect(result.last[:name]).to  eq "Zalito" }
    end
  end

  describe '.sanakeize!' do
    it 'returns a symbol in snake_case' do
      expect(User.sanakeize!(:CamelCaseText)).to eq :camel_case_text
      expect(User.sanakeize!("CamelCaseText")).to eq :camel_case_text
    end
  end

  describe '.direction' do
    it 'returns :reverse when passing desc' do
      expect(User.direction(:desc)).to eq :reverse
      expect(User.direction('desc')).to eq :reverse
    end

    it 'returns :order when passing asc' do
      expect(User.direction(:asc)).to eq :order
      expect(User.direction('asc')).to eq :order
    end

    it 'returns :order when passing something different of asc or desc' do
      expect(User.direction(:bla)).to eq :order
      expect(User.direction('de')).to eq :order
    end
  end
end
