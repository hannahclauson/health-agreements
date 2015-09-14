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
  - and make sure the seed works for heroku
  - AAand make sure the mailer is configured properly on heroku
  - Restrict signup to only be done by admin
- Update company schema / controllers: (##est 0.5 day)
  - want to see edit times / etc
  - plus helpful as I build public facing functionality (search / etc)
  - may get all this for free already -- via active admin
  - active admin / libsass -- http://stackoverflow.com/questions/26688631/using-libsass-with-rails-asset-pipeline
- Add some tests!!!! (##est 1 day)
  - Esp around practice uniqueness
  - And around badge eligibility / revoking
  - Search
    - params missing (esp practice name/impl)
  - User access to all models
    - anon / editor / admin
    - admin creation not allowed (at least on prod)
- Data Entry Phase II (##est 1 day)
  - will be added to seeds file
  - another few dozen companies
  - refine existing data / review
  - refine badges (definitions / new ones / etc)
- Update IA / copy (## est 0.5 day)
  - Confusing for users difference btw archetype and badge
  - Should probably just be displayed as 'badge' when creating new prototype
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
- Data Entry Phase IV (##est 3 days)
  - big data push - hundreds of sites as goal
  - ideally 1k companies
  - upgrade search (to elastic search?) so that its good / fast
- Request Addition / Modification (##est 1 day)
  - form to request a company added to list
  - form to request a modification
  - form for new badge type?
  - should notify editors via email when new submission in place
- Add model / list of Articles/Journals where company research is published (##est 1 day)
  - and add weighted impact scores to company
  - maybe different badge for active / impactful research?
- Pre-Launch (##est 1/2 day)
  - audit ALL capitalized words to make sure they are used / match whats used in ietf RFCs
  - make sure errors are handled properly
- Launch Site (##est 1 day)
  - marketing time


Nice to Haves:

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