class Tax::Vehicle < ApplicationRecord
	before_create :generate_reference_number

	def generate_reference_number
		self.reference_number rand(10**5..10**6-1)
	end
end
