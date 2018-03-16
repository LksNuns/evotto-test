require 'spec_helper'

RSpec.describe Database do
  subject(:database) { Database }

  describe 'When starts and create a users table' do
    subject(:database) { Database.instance.users.columns }

    it { is_expected.to eq %i[id name age project_count total_value] }
  end
end
