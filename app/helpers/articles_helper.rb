module ArticlesHelper
  def publishing_time(ar_timestamp)
    ar_timestamp.strftime('%m.%d.%Y')
  end
end
