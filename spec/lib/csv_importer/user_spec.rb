require 'spec_helper'

RSpec.describe CsvImporter::User do
  let(:file) { File.join(__dir__, '../../support/users.csv') }

  describe '.to_database' do
    let(:users) { Database.instance.users }

    before { CsvImporter::User.to_database(file) }

    it 'imports data from .csv file to users table' do
      expect(users.count).to be 5
    end
  end
end
