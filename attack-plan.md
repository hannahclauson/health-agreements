  - more rebuild tests
    - should not show (and shoult set rebuild_needed) when there are no more BPs
- Add search tests (##est 0.5 day)
  - fix bug w UI
  - params missing (esp practice name/impl)
- Make production ready (##est 1 day)
  - add ToS - IANAL / etc - for information purposes ONLY / starting point not legal advice
   - proper error handling
X  - add mixpanel / GA
  - do DB dump / restore (make sure works w minimally new data)
- Add model / list of Articles/Journals where company research is published (##est 1.5 days)
  - and add weighted impact scores to company
  - maybe different badge for active / impactful research?
  - Sort search by impact factor
- Company comparison view (##est 0.5 days)
- Make mobile version (##est 2 days)
  - webkit
  - no IE
X- Data Entry Phase II (##est 1 day)
X  - another few dozen companies
X  - refine existing data / review
X  - refine badges (definitions / new ones / etc)
 - enter on prod DB / site
- Update copy (## est 1.0 day)
  - badges on index view should look better (probably just icon)
  - Use these (http://getbootstrap.com/components/#thumbnails) to make callouts on home page
    - Learn about guidelines / badges
    - Showcase Good Citizens
    - content to explain how data extracted / badges awarded
    - companies w the highest impact factor
    - Highlight some common searches / most frequent searches?
- Setup WP blog / subdomain (##est 3 days)
  - prioritize BP buffer
  - publish 1-3 articles
- Data Entry Phase III (##est 2 days)
  - make sure all document links are specified
  - should have about a hundred companies
  - let run for a week or so to see how data performs
  - include test company (maybe this site itself) to validate change detection
  - paginate company index
  - include public sector data sources? data.gov
- Soft Launch Site (##est 1 day)
  - upgrade middleware (puma / unicorn)
  - have mechanism for high fidelity DB backup / routinely do this
x  - decide on a name
x  - buy domain / setup DNS
  - estimate monthly costs
  - add to my contracting firm?
  - bugs
    - vertical style gaps on homepage
  - update mailer
    - setup company name / etc
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
- Automate articles (##est 3 days)
  - probably want to automate this if at all possible
  - maybe not a bad idea to have list of links for each company where they list their articles
  - and detect if/when those pages change / have content added
- Setup Notifiers (##est 1 day)
  - for company updates
  - for new articles
- Crawler to generate company list (##est 1 day)
- Data Entry Phase IV (##est 3 days)
  - big data push - hundreds of sites as goal
  - ideally 1k companies
- Work w EFF / restructure badges (##est 5 days)
  - rework badges / migrate / etc
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
=== Milestone: Launch (v 1.1)

- Request Addition / Modification (##est 1 day)
  - form to request a company added to list
  - form to request a modification
  - form for new badge type?
  - should notify editors via email when new submission in place


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