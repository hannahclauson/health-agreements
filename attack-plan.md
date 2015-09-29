- Merge in refactor
- Add some tests!!!! (##est 1 day)
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
    - practice
X      - create (via comp)
      - create (via arch)
      - edit (via comp)
      - edit (via arch)
X      - show (via comp)
      - show (via arch)
      - update (via comp)
      - update (via arch)
      - destroy (via comp)
      - destroy (via arch)
    - archetype
      - index
      - show (incl practices)
      - edit
      - update
      - destroy
    - badge (has no controllers), so no access to:
      - show
      - index
      - edit
      - delete
    - Search
      - params missing (esp practice name/impl)
    - For badge
      - new eligilibity / count
      - remove eiligilibity / count
      - via archetype updates
      - via company updates
- Data Entry Phase II (##est 1 day)
  - will be added to seeds file
  - another few dozen companies
  - refine existing data / review
  - refine badges (definitions / new ones / etc)
- Update IA / copy (## est 0.5 day)
  - Confusing for users difference btw archetype and badge
  - Should probably just be displayed as 'badge' when creating new prototype
  - badges on index view should look better (probably just icon)
  - Use these (http://getbootstrap.com/components/#thumbnails) to make callouts on home page
    - Learn about guidelines / badges
    - Highlight some common searches / most frequent searches?
    - Showcase Good Citizens
- Make production ready (##est 1 day)
  - add ToS - IANAL / etc - for information purposes ONLY / starting point not legal advice
  - proper error handling
  - add mixpanel / GA
- Setup polling data (##est 1 day)
  - crawl/save/hash all agreements so we can track changes + alert when info may be out of date
  - probably want to separate download of html from extracting corpus
    - that way the content selector / normalization can always be updated independently
    - can even get super OCD w the practices per comp and require that they list a 'line number' or range from their parent document where they are defined
    - then when diffing, I should be able to tell exactly which practices are affected
  - New model: Document
    - URL
    - poll date
    - hash
  - Company has_many documents
  - Async jobs to get these periodically
  - New view (for companies) to see revision history per document type
    - comparison view to compare two versions (visualize diff)
  - alerts  / UI changes to denot
  - cost est for this amt of data / traffic
- Data Entry Phase III (##est 2 days)
  - will be added to prod DB
  - do DB dump / restore (make sure works w minimally new data)
  - make sure all document links are specified
  - should have about a hundred companies
  - let run for a week or so to see how data performs
  - include test company (maybe this site itself) to validate change detection
  - paginate company index
- Soft Launch Site (##est 1 day)
  - upgrade middleware (puma / unicorn)
  - have mechanism for high fidelity DB backup / routinely do this
  - estimate monthly costs
  - add to my contracting firm?
  - publish / make OSS?
  - bugs
    - vertical style gaps on homepage
  - update mailer
    - setup company name / etc
- Data Entry Phase IV (##est 3 days)
  - big data push - hundreds of sites as goal
  - ideally 1k companies
- Request Addition / Modification (##est 1 day)
  - form to request a company added to list
  - form to request a modification
  - form for new badge type?
  - should notify editors via email when new submission in place
- Add model / list of Articles/Journals where company research is published (##est 1 day)
  - and add weighted impact scores to company
  - maybe different badge for active / impactful research?
  - probably want to automate this if at all possible
  - maybe not a bad idea to have list of links for each company where they list their articles
  - and detect if/when those pages change / have content added
- Data Entry Phase V - Articles (##est 1 day)
  - Review any articles for at least a dozen companies
  - Some have many (23andme / etc)
  - Probably enter ~ a few hundred articles
  - Update homepage callout for companies w articles / articles index page
- Pre-Launch (##est 1/2 day)
  - audit ALL capitalized words to make sure they are used / match whats used in ietf RFCs
  - make sure errors are handled properly
- Launch Site (##est 1 day)
  - marketing time


Nice to Haves:

- Performance upgrade
  - access helpers
    - all my access_to_action() helper calls add up .. esp on index pages
    - can really cache the result of these calls / add to the user model so that they aren't made a ton
    - but bench first I guess
  - badge assignment
    - that ones pretty gnarly
    - start w benchmarks
    - then make a bunch of dummy companies (~1k / 10k) and see how it performs
    - optimize what I can
    - open to refactoring schema
    - or doing batch / background job
- Mobile version
  - if im marketing ... its probably going to be seen first on mobile
- Update UX
  - on company show page, provide JS filters for each column (prob at least implements col)
  - maybe also provide option to see all guidelines (and whether they follow or now)
  - company comparison view -- compare company's implementations of (all? -- at least union) or practices
- Comparison Functionality
  - compare companies (2+?)
- Add script to dump current DB to a seeds.rb file
  - a la : http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html
  - will be handy as I go through iterations of populating the DB and revising the content
- if they support public peer-reviewed research, links to relevant studies
  - articles are a new model
  - would like to save name / journal / impact factor
  - provide weighted impact score for company
UX upgrade
  - update index pages
    - badges - sort by date
    - updated agreements (new docs)
  - update credits page w example of icons -- need to abstract badge helper some more
  - make search by badge use badge icons?
- Add user based submissions
  - is there a way to use linkedin to verify you're a lawyer?
  - or a public registry for identity / prove you passed the bar?
  - would be nice to be able to have lawyers volunteer their time in some capacity
- Add developer API for access to the information programmatically
- Other info / models
  - Studies (esp open enrollment / results / etc)
    - e.g. amiigo's project pulse / other med studies / FDA studies?
  - private research results? blog posts?
- Testing update
    - View button testing
      - use view tests to validate action buttons
      - are present only as appropriate (see http://guides.rubyonrails.org/testing.html section 4.8)
