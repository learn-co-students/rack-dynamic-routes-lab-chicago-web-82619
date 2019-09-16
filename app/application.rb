class Application

    @@items = [Item.new("Apple", "5.25"), Item.new("Avocado", "3.50"), Item.new("Figs", "3.42")]
    
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            search_item = @@items.find{|i| i.name == item_name}
            if @@items.include?(search_item)
                resp.write search_item.price
            else
                resp.write "Item not found"
                resp.status = 400
            end  
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end
