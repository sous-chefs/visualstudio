# frozen_string_literal: true

name 'visualstudio'

default_source :supermarket

run_list 'recipe[visualstudio]'

named_run_list :default,
               'recipe[visualstudio]',
               'recipe[visualstudio::install_update]',
               'recipe[visualstudio::install_vsto]',
               'recipe[minitest-handler]'

cookbook 'visualstudio', path: '.'
cookbook 'minitest-handler',
         git: 'https://github.com/b-dean/minitest-handler-cookbook.git',
         branch: 'chef-13-fix'
cookbook 'sqlce'

default['minitest']['recipes'] = %w(
  visualstudio::install
  visualstudio::install_update
  visualstudio::install_vsto
  visualstudio::nuget
)
