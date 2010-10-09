# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lolcount_session',
  :secret      => 'd19fdf7a9dcdd09142754d01989774b78cf7167ef76a4b79a38bda7242d44df91c2d7cdf16be81fb793152f9ec55813f3c1267a475f111e05a9922d654ea67a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
