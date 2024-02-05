# Install bootstrap:
    Add gem 'cssbundling-rails' and run 'rails css:install:bootstrap'
    To pin bootstrap and popperjs in Importmap: run './bin/importmap pin bootstrap'

# Install Devise:
    run 'rails g devise:install'
    run 'rails g devise user first_name last_name date_of_birth:date username city state country pincode street_address profile_title about:text'