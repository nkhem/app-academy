class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name, :params

# path to match: /users, /users/new, /users/(\d+), /users/(\d+)/edit, etc.
# controller: UsersController
# method: GET, POST, PUT, DELETE
# action_name: action name that should be invoked

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, @controller_class, @action_name =
      pattern, http_method, controller_class, action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    @pattern.to_s.match(req.path) && @http_method.to_s.match(req.request_method.downcase)
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    @params = req.params
    controller_class.send(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    new_route = Route.new(pattern, method, controller_class, action_name)
    @routes << new_route
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method)
  end

  # should return the route that matches this request
  def match(req)
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    # The #run method will figure out what URL was requested, match it to
    # the path regex of one Route object, and finally ask the Route to
    # instantiate the appropriate controller, and call the appropriate method.
  end
end
