require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /v1/users' do
    let(:uuid) { faked_firebase_uid }
    let(:headers) { build_header(sub: uuid) }

    it { is_expected.to eq(200) }
  end
end
