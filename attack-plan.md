- Create company scaffold (mvc)
  - create company view
  - create list view
  - make 'new' view
  - make seed data
  - Deploy to heroku
- Update company schema / controllers:
  - hook in activeadmin for company creation for now
    - will this suffice for relationships too?
  - add fields:
    - website
    - privacy link
    - Terms of Service link
  - update seeds
- Create 'metric' model to describe how an aspect of a company's relationship w its users
  - these will correspond to the columns in my GSS
  - e.g. 'special consent for minors' (T/F)?
  - e.g. 'research data without authorization?'
  - generally all true or false
  - Company <-> metric is one to many
- Create 'badges' model to show succinct information about a company's use of health data
  - e.g. 'Public Research' icon - they provide info for research
  - e.g. 'Privacy Warden' icon - they only share info w explicit consent
  - badge -> metric is one to many
  - Build basic iconography to represent important aspects of agreements


Nice to Haves:

- if they support public peer-reviewed research, links to relevant studies
- crawl/save/hash all agreements so we can track changes + alert when info may be out of date
- Add user based submissions
  - is there a way to use linkedin to verify you're a lawyer?
  - or a public registry for identity / prove you passed the bar?
  - would be nice to be able to have lawyers volunteer their time in some capacity