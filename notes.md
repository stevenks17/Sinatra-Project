User
---
has_many :reviews ***
User can edit own reviews ***
Users can view anyones reviews
User can delete own reviews only **

Reviews
---
belongs_to :user ***
Reviews will show who posted the review ***


Design
---
layout can have login logout ***
Might be better to merge show pages and have functionality be on review_entries/show not user/show so we have single purpose.




Bugs
---
Controller Bugs:

Viewing other peoples reviews redirects to index?
Delete works but does not redirect correctly?



Stretch Goals
---
stretch feature users can comment on movie reviews