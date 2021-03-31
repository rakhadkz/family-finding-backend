module Generator
  def username_generator
    def generate_username(full_name)
      ActiveSupport::Inflector.transliterate(full_name) # change ñ => n
        .downcase              # only lower case
        .strip                 # remove spaces around the string
        .gsub(/[^a-z]/, '_')   # any character that is not a letter or a number will be _
        .gsub(/\A_+/, '')      # remove underscores at the beginning
        .gsub(/_+\Z/, '')      # remove underscores at the end
        .gsub(/_+/, '_')       # maximum an underscore in a row
    end
  end
end