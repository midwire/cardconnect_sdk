require 'spec_helper'

module CardconnectSdk
  module Profile
    RSpec.describe DeleteResponse, type: :lib do
      it_behaves_like 'approved, retry, or declined'
    end
  end
end
