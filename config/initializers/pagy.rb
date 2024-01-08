Pagy::DEFAULT[:page] = 1
Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:page_param] = :core
Pagy::DEFAULT[:cycle] = true

require 'pagy/extras/bootstrap'
Pagy::DEFAULT.freeze