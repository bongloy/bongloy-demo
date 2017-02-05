module Bongloy::SpecHelpers::FeatureHelpers::FormHelpers
  private

  def native_fill_in(label, options = {})
    raise("Must pass a hash containing :with") unless options.has_key?(:with)
    input = find_field(label)
    input.native.send_keys(*(([:backspace] * 50).unshift(:end))) if options[:clear]
    # split string into maximum of 2 characters (because of autoformatting)
    options[:with].to_s.scan(/.{1,2}/).each do |segment|
      input.native.send_keys(segment)
    end
  end
end
