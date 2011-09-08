Installation
============

As near as I can tell installation is straightforward. It uses sqllite (for now) requires ruby 1.9.2. I do:

    rvm install ruby-1.9.2-p290
    rvm ruby bundle install

and it does it right. If (for some reason) this doesn't work for you, please notify me (or pull-request).

Buildings
=========

All of the resource management for v-t is based on (unsurprisingly) Villages and Buildings. Buildings are STI so that the business logic can be managed by the individual models themselves. There isn't that much differentiation between buildings in terms of data stored. They're a collection of rules and tasks. They are dependent on Village Resources for most of their functionality. Village Resources are a poorman's document store. We never really care about what resources are in there so it's just a serialized hash of what this village has. Buildings contribute all of their outputs to the entire village.