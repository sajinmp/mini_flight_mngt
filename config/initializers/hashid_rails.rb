Hashid::Rails.configure do |config|
  # The salt to use for generating hashid. Prepended with table name.
  config.salt = "f25426d79485143ce5a44cdc7efa7ee73fddbddbeac9623d4dc72029d8303a9d744ddf36296b7947ab7eed83b646cc6c0e6168990a552ddd2f8e52034326c8fb"

  # The minimum length of generated hashids
  config.min_hash_length = 8

  # The alphabet to use for generating hashids
  config.alphabet = "abcdefghijklmnopqrstuvwxyz" \
                    "ABCDEFGHIJKLMNOPQRSTUVWXYZ" \
                    "1234567890"

  # Whether to override the `find` method
  config.override_find = true

  # Whether to sign hashids to prevent conflicts with regular IDs (see https://github.com/jcypret/hashid-rails/issues/30)
  config.sign_hashids = true
end
