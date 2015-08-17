# URLs
Staging can be found at [whiteboard-acceptance.cfapps.io](whiteboard-acceptance.cfapps.io)
Prod is either [whiteboard-production.cfapps.io](whiteboard-production.cfapps.io) or [whiteboard.pivotallabs.com](whiteboard.pivotallabs.com)
For CI, we use [Travis](https://travis-ci.org/pivotal/whiteboard).

# How to Deploy
We use [Evaporator](https://github.com/pivotal/evaporator) to deploy Whiteboard.
Following Evaporator convention, there's `config/cf-staging.yml` that provides configuration for the `cf:deploy:staging` command. 
To deploy to staging, authenticate with PWS via cf-cli, and run `SPACE=whiteboard bundle exec rake cf:deploy:staging`
