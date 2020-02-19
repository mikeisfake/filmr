# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
1. `movie` has_many `reviews`
2. `user` has_many `reviews`
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
1. `review` belongs_to `movie` & `user`
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
1. `tag` has_many `reviews` through `review_tags`
2. `review` has_many `tags` through `review_tags`
3. `user` has_many `movies` through `reviews`
4. `movie` has_many `users` through `reviews`
5. `movie` has_many `tags` through `reviews`
6. `tag` has_many `movies` through `reviews`
7. `movie` has_many `tags` through `reviews`
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
1. tags have user submittable names.
2. reviews are user submittable.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
1. User
2. Review
3. Tag
4. Movie
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
1. Movie has [`:user_movies`](http://localhost:3000/movies)
2. Movie has [`popular_this_week`](http://localhost:3000/dashboard)
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
1. ^ used devise gem.
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
1. [shows a users reviews](http://localhost:3000/profile/8/reviews)
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
1. [create a new review of a movie](http://localhost:3000/movies/155/reviews/new?)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
