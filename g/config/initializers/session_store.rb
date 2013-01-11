# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_g_session',
  :secret      => '0020730046304fff02025eeedae6f9d0d8762feb44fbfd20d5c62781b67750c15a34a353e0d35a82a93fe4a58f3b2678c292332cd87aad861c69bff1f1809167'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
