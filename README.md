# Goal Tracker
See it live: [renata-goal-tracker.herokuapp.com](https://renata-goal-tracker.herokuapp.com/?utm_source=github&utm_medium=readme&utm_campaign=github)

![Goal Tracker preview](https://renatacumminsprojectgifs.s3.amazonaws.com/goal_tracker.gif)

## Application description
Goal Tracker is an app where you can track your public and private goals and cheer on other users as they make progress on their goals. Goal Tracker allows users to:
* Create an account and log in/out
* Create and edit your own goals
* Control who can see your goals with the privacy setting
* Mark goals as complete
* Comment on any user's page and any goal that's visible to you

## Design docs
* [MVP feature list](https://github.com/rcummins/goal_tracker/wiki/MVP-feature-list)
* [Database schema](https://github.com/rcummins/goal_tracker/wiki/Database-schema)
* [Routes](https://github.com/rcummins/goal_tracker/wiki/Routes)

## Highlighted features

### Polymorphic associations for comments

I used polymorphic associations so that a single comments model could be used to add comments on a user's show page and on a goal's show page. I added the belongs_to association to the Comment class and factored out the has_many associations for the User and Goal classes into the Commentable module to keep my code DRY. Here are the relevant lines of code:

```Ruby
# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
end

# app/models/user.rb
class User < ApplicationRecord
  include Commentable
end

# app/models/goal.rb
class Goal < ApplicationRecord
  include Commentable
end

# app/models/concerns/commentable.rb
module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end

end
```

### Custom SQL query to calculate total goals and completed goals by user

I wanted the user index page to display the total number of goals and the number of completed goals owned by each user. I wrote a custom SQL query to calculate these totals from the database:

```Ruby
# app/models/user.rb

class User < ApplicationRecord
  def self.get_all_users_info
    User
      .select(
        "users.id,
        users.username,
        users.session_token,
        users.created_at,
        COUNT(goals.id) AS total_goals,
        SUM(
          CASE
            WHEN goals.completion = 'Completed' THEN 1
            ELSE 0
          END) AS completed_goals"
      )
      .left_outer_joins(:goals)
      .group(
        'users.id,
        users.username,
        users.session_token,
        users.created_at'
      )
  end
```

## Future
Feel free to share any suggestions you might have for improvements to Goal Tracker! Here are some features I would like to add in the future:
* Users can add a comment in response to a previous comment
* Users can add steps to a goal and mark each step as completed
