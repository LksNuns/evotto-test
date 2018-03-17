require 'spec_helper'

RSpec.describe User do
  before do
    User.dataset.destroy
    %w[Paulo Zalito João Afonso].each { |name| User.create(name: name) }
  end

  # TODO Corrigir testes
  skip describe '.find' do
    it 'returns users with matched name' do
      expect{
        User.find('Afonso')
      }.to output(
        <<~EOF
          NAME | Age | ProjectCount | TotalValue
          Afonso |  |  |
        EOF
      ).to_stdout
    end
  end

  # TODO Corrigir testes
  skip describe '.order_by' do
    it 'returns users ordered by :name asc' do
      expect{
        User.order_by(:name, :asc)
      }.to output(<<~HEREDOC
        NAME | Age | ProjectCount | TotalValue
        Afonso |  |  |
        João |  |  |
        Paulo |  |  |
        Zalito |  |  |
      HEREDOC
      ).to_stdout
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
