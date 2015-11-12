- Bugs (## est 0.5 day)
  - features
x    - turbolinks fucks w nav menu / listeners - need to rebind
x    - fix articles show
x      - decide if ill expose it / kill it (KILL IIIIIT)
x    - fix search on company index
x      - style for adv search on desktop
x      - search just disappeared altogether
x    - update badges on homepage --- should link to each search by badge
x    - search should populate inputs w values that we used for the search
x      - and should show the advanced options if those were used
x    - auto scroll on mobile -- this isnt a thing anymore
x    - change 'show' buttons to 'learn more / details'

  - styles
    - that damn gap by the footer
    - flash message styling
    - buy other nouns from noun project
    - navbar styles on badges index page
    - badge row styles on badges index
    - homepage heading
    - badges on HP gaps are off a bit

x  - search by badge not autocomplete - false error
x  - make sure tests passing
- Document stubs (## est 0.25 day)
  - page for ICV context
  - page for describing extraction process?
- Contribute (## est 0.5 day)
  - article - form
  - company req - form
  - legal volunteer - email


- Company field update
  - add fields for tos/pp/eula/etc - any other documents
  - add LegalDocuments
    - has many practices
    - belongs to company
    - should prob event be btw comp/practice ... this way is a bit redundant
  - add migration
  - update view / edit
  - don't require it as a field when creating practice
  - go through all companies on prod
  - once they have it
  - then require it / test on local prod DB dump
  - add tests
    - clone of practices sub tests rom company cont
    - shows up in practices view -- new practice requires doc

- Data Entry Phase III (##est 2 days)
  - make sure all document links are specified
  - should have about a hundred companies
  - let run for a week or so to see how data performs
  - include test company (maybe this site itself) to validate change detection
  - paginate company index
  - include public sector data sources? data.gov
  - enter on prod DB / site
- Data Entry Phase IV - Articles (##est 1 day)
  - Review any articles for at least a dozen companies
  - Some have many (23andme / etc)
  - Probably enter ~ a few hundred articles
  - Update homepage callout for companies w articles / articles index page
  - maybe different badge for active / impactful research?
  - paginate journals / articles as needed (prob need to make articles index subview of comp)

--- goal for ODSC ---

  - transition all admin stuff to SOH email
    - new relic
    - heroku
    - DNS
    - thenounproject
    - sendgrid
    - bot for deployment on git --- symbolofhealthbot@gmail.com // HM
    - circleCI - esp notifications


- Setup WP blog / subdomain (##est 3 days)
  - prioritize BP buffer
  - publish 1-3 articles
  - transition DNS to SOH email / acct
- Setup Notifiers (##est 1 day) -- nice to have
  - for company updates
  - for new articles
  - update mailer
    - setup company name / etc
- Track users (##est 1 day) -- nice to have
  - add mixpanel
    - interesting / can track sep actions
    - will be good once we have users
    - will save for v1.0
== Milestone: Soft Launch (v 1.0)
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
- UI tweaks
  - breadcrumbs? - esp for spec company practice
  - mobile nav menu coloring
- Automate articles (##est 3 days)
  - probably want to automate this if at all possible
  - maybe not a bad idea to have list of links for each company where they list their articles
  - and detect if/when those pages change / have content added
- Crawler to generate company list (##est 1 day)
- MISC (##est 1 day)
  - setup nightly transfers of prod DB to staging
  - run test suite twice - once w mobile UA
    - e.g. that bug w search where I had removed the input, so there was an err
- Data Entry Phase V (##est 3 days)
  - big data push - hundreds of sites as goal
  - ideally 1k companies
  - paginate company index
  - look into in mem caching for rails
  - upgrade middleware (puma / unicorn) - estimate monthly costs
- Work w EFF / restructure badges (##est 5 days)
  - rework badges / migrate / etc
- Pre-Launch (##est 1/2 day)
  - audit ALL capitalized words to make sure they are used / match whats used in ietf RFCs
  - make sure errors are handled properly
- Launch Site (##est 1 day)
  - marketing time
=== Milestone: Launch (v 1.1)



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
- Subscribe to a company
  - email notification if terms change
  - so that you're proactively aware of the changes