module Bongloy::SpecHelpers::TranslationHelpers
  private

  def translate!(*keys)
    options = keys.extract_options!
    I18n.t!(keys.join("."), options)
  end

  def translate_simple_form!(*keys)
    translate!(:simple_form, *keys)
  end

  def translate_label_for!(input, options = {})
    scope = options.delete(:resource) || :defaults
    translate_simple_form!(:labels, scope, input, options)
  end
end
