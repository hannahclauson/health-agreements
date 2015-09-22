Hampton - 9/22/15

- ruby 2.2.2?
- 

High Level

- start w application controller
- what is reused
- 

different schema
- heavy save (after_save filter) on eahc new object
- no more hairy giant loop, each obj udnerstands what it may need to update

protip

- Guideline.find repetition
- private helper method to find
- define it as a helper method to make avail i ntemplates

loves atom
- super extensible
- nailed packages
- avail updates
- emacs plugins .... dooo it

DB backup?

- simple command

protip

- work through piece by piece
- once you hit the point where you need to change a bunch ...
- dont worry about getting migrations perfect
- copy everything in the schema
- put it all in a single migration
- terrible idea in production
- good for prototyping schema
- for prod you leave in place ... ? 

btree - type of index - balanced tree
 (line 34 -- removed these lines bcz its auto gened)
- makes it so the order matters?
- multikey index works left to right / subtrees
  - eg add_index "badge_awards", ["badge_id", "company_id"]
  - creates company subtree for each badge subtree
  - lets you search for the left one (badge)
  - this is why you'll see a line reversed for searching the other way

- add cmopany field - 'slug' for url version of the name
- the ruby toolbox (.com) -- great reference
- permalink + slugs (friendlyID)
- changed mind to babosa
- same coder, more recent projext
- more extensions
- less heavy (doesnt make a table?)

- HC super cacheable
- memcached plugin for $5/mo
- rails cache

- QN: Users
- better way to do role / checking
- use cancan if worried about holes
- makes one file w all of ifs
- use it in views as a can_xxx?

Postgres vs MySQL vs Mongo

- knows mysql really well - more popular
- postgres tech superior
- new thing - mariadb - fork of mysql who left (before it got bought by oracle)
- use amazon's RDS - manages mysql - $100/mo -- big server
- every site ever uses that single instance
- keep it up
- for wordset using mongolab
- its now more mature (don't lose prod data)
- good for random access over documents



Scaling?

- elastic search? 

Company controller

- has many through -- makes easy company.badges helper (so dont have to join specifically)

PRactice Model

- enum stuff shoudl all be in a concern
- concern is a way to make modules just bits of code to get dropped in
- and will make practices and badgepractices comparable



Forms -- use f.fields_for
- and can use f.object inside partial

for passing nested params,

params.require(:badge).permit(:name, :badge_practices_attributes => {:implementation, :guideline_id} }


diff btw .new and .build

build is same thing ... just scoped ... so builds on already pointed propery:

@badge.practices.build

controller - private method

current_badge / current_badge_practice

protects against updating wrong objects (esp ones that dont exist) - common hack to protect against

enumated helpers --- under practices model, but avail everywhere? global namespace?


Badge assignment

- in practice model

walk over guideline's assoc badges (so badges that use the new guideline)
- then find all the badges that have guidelines for the ruels in place (not checking match. ... just checking that they exist)

use 'rebuild' and 'calc' button on badge creation page to decide when you want to run the check against all companies

--

use slug names for classnames / etc

when you do rake db:setup it uses schema.rb hwich is faster

magical method on ebery model --- "to_param"
usually id
now we'll type slug
and now it will use the dash name

need to update links to badges to use slug name ... so overide to_param method on badge









