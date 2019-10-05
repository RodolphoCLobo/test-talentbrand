require 'rails_helper'

RSpec.describe Priority, type: :model do
  it { is_expected.to have_db_column(:status).of_type(:string) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to have_many(:notes) }
end
