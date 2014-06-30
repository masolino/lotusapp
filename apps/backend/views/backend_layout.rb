module Backend::Views
  class BackendLayout
    include Backend::Layout
    
    def page_title
      "Backend - "
    end
  end
end
