require 'rails_helper'

RSpec.describe GeocodeService, type: :model do
    describe 'class mehtods' do 
        it '#get_location', :vcr do 
            response = GeocodeService.get_location('denver,co')

            expect(response[:lat]).to eq(39.738453)
            expect(response[:lng]).to eq(-104.984853)
        end 
    end 
end