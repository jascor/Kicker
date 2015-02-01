class BaseModel < ActiveRecord::Base
  self.abstract_class = true

  #def as_json(options)
    #Hash[self.class.name.camelize, super()]
  #end
end