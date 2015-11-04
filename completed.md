- Create company scaffold (mvc) - X
  - create company view - X
  - create list view - X
  - make 'new' view - X
  - Deploy to heroku -X
  - add validators - X
  - add udpate method - X
  - refactor views into partials - X  
  - create delete method - X
- Think about new model a bit before generating - X
  - I want abstract 'guidelines' that a company implements some way via a 'practice' - X
- Create 'guideline' model
  - abstract rule that can be followed - X
  - name - X
  - desc - X
  - truth_value - description of what it means to be followed - X
  - false_value - what it means to not be followed - X
  - make CRUD actions / views - X
- Create 'practice' model - X
  - these will correspond to the columns in my GSS
  - belongs_to: guideline
  - belongs_to: company (a company has_many: practices)
  - implementation of a guideline for this company. Do they follow it? t/f/n-a/ambiguous?
  - later on will probably want the values to be a proper enum ... for now int is fine
  - e.g. 'special consent for minors' (T/F)?
  - e.g. 'research data without authorization?'
  - generally all true or false
  - later on ... the 'parent' object will the Document object (which legal doc did the guideline come from?) ... this is important because as I track changes, I'll need to know which guidelines are possibly out of date
- Data entry phase I
  - enter data for ~12 companies
    - enter a set of guidelines
    - then fill in companies / practices for all relevant guidelines
  - maybe ideally a few dozen ... like 50?
  - push to heroku and seed there
- Consolidate some layout / IA
  - make seed data - X
    -  seed script - X
    - so I can seed DB on heroku - X
  - update homepage - X
  - get header working / layout/application views inheriting properly - X
  - add some basic docs
    - basic ToS - X
    - define terms (a la RFC) : MUST / SOME / NEVER / ALWAYS / MAY etc - X (linked to ietf description ... should later clean up the words used to make sure they match up)
    - would also be helpful to define a glossary of terms: - X
      - usage data (ip address / cookies / order history)
      - health data (personal metrics on health)
      - aggregate data
  - add footer - X
- Basic styling
  - bootstrap
    - make header look good - X
      - navbar - X
      - logo / title - X
    - make footer look good - X
      - dark color      
    - homepage - X
      - jumbotron style?
    - make company show look good - X
      - use panels / table styles for list of practices
    - fix some styles - X
      - fix highlight style -- I messed up the colors for the highlighting of active state in the nav bar ... think I just need to namespace the styles I added properly
      - same highlight issue in footer
    - make company edit look good - X
      - lots of form helpers / fieldsets - X
    - same for practice show (needs more description around how it relates to its guideline) -X
    - same for guideline show / edit - X
      - provide a guideline 'landing page' to explain how they work
      - guess I found a use for guideline#index after all
  - update the color palette - X
- Thought a bit more on badges, going w the following schema:
  - 'archetype' object
    - is abstract set of practices that one must follow to earn a badge
    - has_many practices
    - has_many badges
  - 'badge' obj
    - stamp of adherance to a set of guidelines
    - belongs_to: company
    - belongs_to: archetype
- Implement new models
  - Archetype
    - index / show / edit / delete
      - show (should have form inline to add practices)
  - Badge
    - list on company show page
    - when practices updated on COMPANY parent object ...
      - there should be a check to see if it implements any badges / if any existing badges need to be removed
    - when practices updated on ARCHETYPE parent object ... need to re-index all badges!!!?!?
      - that seems like it will take quite a long time
      - cant just negate existing badges that use archetype ... because new companies may qualify for the badge
      - maybe negate the ones that have it ... then update the ones that are newly eligible next time they're saved? Or kickoff long term job to cycle through those?
      - wont be an issue immediately ... but eventually if there are 10k company rows ... this is will be costly
      - then again ... probably wont be adding / changing badges very often
    - shouldn't have to add anything special to seeds as long as a company implements an arch, they should get the badge upon guideline creation
- Badge
  - Build basic iconography to represent important aspects of agreements
- Update seeds
  - Add a few archetypes
  - hmmm now im now populating companies correctly ...
    - i think this may have happened whn i introd polymorphism
  - update seeds.rb to populate archetypes
  - Make sure some companies implement none/one/some
- Get icon paths working on heroku
  - this is prob going to be annoying
X  - also adjust the icon styles -- would like to be white on dark blue
X - OMG this was so silly -- this helped me out (kinda) : https://github.com/rails/sass-rails/issues/86
X - I spent sooo much time on this ... compared to everything else. Like ... 3+ hours

X- Create search methods (##est 1 day)
X  - search by badge
X  - search by practices (and value)
X  - update company index
X    - display badges in each row

- Create users (##est 1 day)
X  - use devise (seems standard)
X  - editor-level and admin-level roles
X  - style signin/signup views
X  - views / access to update:
X    - companies
X    - guidelines
X    - practices
X    - archetypes
X  - non session users cannot:
X    - edit/delete anything
X  - only editors can
X    edit/create:
X    - companies (& therefore practices / badges)
X    - archetypes? not sure about this one ... I guess for now
X    - guideline    
X  - only admins can
X    - delete anything
X    - create new editors
X  - make sure to seed DB w admin user
X  - and make sure the seed works for heroku
X  - AAand make sure the mailer is configured properly on heroku
X  - Restrict signup to only be done by admin

- Update company schema / controllers: (##est 0.5 day)
  - want to see edit times / etc
  - plus helpful as I build public facing functionality (search / etc)
  - may get all this for free already -- via active admin
  - active admin / libsass -- http://stackoverflow.com/questions/26688631/using-libsass-with-rails-asset-pipeline

- Merge in refactor
- Fix all tests / Add some tests!!!! (##est 1 day)
  - Model tests: For company/guideline/practice/archetype
    X - creation / empty
    X - each validator
X    - Deletion special cases
X      - any dependent destroys
X        - guideline -> practices
X        - archetype
X          - badges
X          - practices
X        - company
X          - practices
X          - badges
X  - Remove badge name/desc from migration and rerun
X    - I'm using the archetype fields anyway
#  - What if there is an archetype with no practices?
#     - for since only editors can create, will make do
  - Controller tests (including access levels):
X    - company
X      - index
X      - new
X      - create
X      - show (incl practices)
X      - edit
X      - update
X      - destroy
X    - guideline
X      - index
X      - new
X      - create
X      - show
X      - edit
X      - update
X      - destroy      
    - fix guideline / practices controller tests
    - practice
      - I HAVE A after_create filter
      - need to add approps for update / destroy
X      - create (via comp)
      - edit (via comp)
X      - show (via comp)
      - update (via comp)
        - w failing badge update
      - destroy (via comp)
        - w badge update test
    - badge
      - index
      - show (incl practices)
      - edit
      - update
        - self
        - need to add failing tests here, then add another column for rebuilt status / and button on show to rebuild this badge
        - badge_practices
        - badge_award changes
      - destroy
        - badge_practices
        - badge_award changes (on badge del or bp del)
X- Update badge / rebuild function (##est 1 day)
X  - should have state / only be usable when modifications in place
X  - add tests for badge_practice creation / badge rebuilding
X  - add cancan here and refactor users / tests
X    - company access
X    - practice access
X    - guideline access
X    - badge access
X    - practice - fold all @practice finds into current_** helepr method and do access control
X      - practices - validate uniqueness on guidelines - why are these commented out in practices model?
X      - looks like moved from comp to practice model - just double check tests are there for this
X    - badge practice access
X      - badge_practices should be removable by editor
X  - remove manual access helpers
X    - no more inheriting from ProtectedController
x  - update all views to use cancancan
x    - badge 
x      - show -> BP add
x      - index - new/edit/delete
x    - company
x      - show -> P add
x      - index -> new/edit/delete
x  - more rebuild tests
x    - should not show (and shoult set rebuild_needed) when there are no more BPs
x- Add search tests (##est 0.5 day)
x  - fix bug w UI
x  - params missing (esp practice name/impl)
x   - redirect on one result
x   - comp name
x   - practice name
x   - practice name & impl
x   - practice impl neg
x   - badge name
X- Make production ready (##est 1 day)
X  - add ToS - IANAL / etc - for information purposes ONLY / starting point not legal advice
X   - proper error handling --- new relic
X - add GA
X  - do DB dump / restore (make sure works w minimally new data)
X- Data Entry Phase II (##est 1 day)
X  - another few dozen companies
X  - refine existing data / review
X  - refine badges (definitions / new ones / etc)
- Add model / list of Articles/Journals where company research is published (##est 1.5 days)
x  - add journal views/actions:
x    - index
x    - show
x    - edit / update
x    - new / create
x    - destroy
x    - tests for these + permissions
x    - add basic seeds
x  - add article views/actions:
x    - index
x    - show
x    - edit / update
x    - new / create
x    - destroy
x    - tests for these + permissions
x    - add basic seeds
x     - model tests
x  - update company model -- articles / impact factor
x  - Sort search by impact factor, test:
x      - for impact factor
x      - for impact factor recalc edge cases
x- Company comparison view (##est 0.5 days)
x  - add action
x  - add view
x  - add test
- Make mobile version (##est 2 days)
x  - detect mobile (webkit / and / win)
x  - add viewport
x  - dont support editors on mobile (modifying objs) - they work but are ugly
x    - menu UI
x    - show:
x      - company
x      - journal
x      - badge
x      - guideline
x      - practice
x    - search / companies !
x    - index
x      - companies
x      - journals
x      - guidelines
x    - doc (tos/etc)
x    - compare companies?
x      - badge icon / text styles

x- Update copy (## est 1.0 day)
x  - badges on index view should look better (probably just icon)
x  - Use these (http://getbootstrap.com/components/#thumbnails) to make callouts on home page
x    - Learn about guidelines / badges
x    - Showcase Good Citizens
x    - content to explain how data extracted / badges awarded
x    - companies w the highest impact factor
x    - Highlight some common searches / most frequent searches?
