ApiPagination.configure do |config|
  # Paginator to use
  config.paginator = :kaminari

  # By default, this is set to 'Total'
  config.total_header = 'Total'

  # By default, this is set to 'Per-Page'
  config.per_page_header = 'Per-Page'
end
