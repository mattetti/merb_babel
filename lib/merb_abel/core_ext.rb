module MerbAbel
  module HashExtension

    def symbolize_keys
      inject({}) do |options, (key, value)|
        options[key.to_sym || key] = value
        options
      end
    end
    
    def symbolize_keys!
        self.replace(self.symbolize_keys)
    end

  end
end


Hash.send :include, MerbAbel::HashExtension
