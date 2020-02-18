require 'pry'
class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match(/items/)
            requested_item = req.path.split("/items/").last
            req_item_obj = Item.all.filter do |item|
                item.name == requested_item
            end
            if req_item_obj.length != 0
                resp.write "#{req_item_obj[0].price}"
            else
                resp.status = 400
                resp.write "Item not found"
            end
            
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end