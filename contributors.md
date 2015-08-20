# URLs
Staging can be found at [whiteboard-acceptance.cfapps.io](whiteboard-acceptance.cfapps.io)
Prod is either [whiteboard-production.cfapps.io](whiteboard-production.cfapps.io) or [whiteboard.pivotallabs.com](whiteboard.pivotallabs.com)
For CI, we use [Travis](https://travis-ci.org/pivotal/whiteboard).

# How to Deploy
We use [Evaporator](https://github.com/pivotal/evaporator) to deploy Whiteboard.
Following Evaporator convention, there's `config/cf-staging.yml` that provides configuration for the `cf:deploy:staging` command. 
To deploy to staging, authenticate with PWS via cf-cli, and run `SPACE=whiteboard bundle exec rake cf:deploy:staging`

# SendGrid
We use [SendGrid](http://sendgrid.com) to send Whiteboard summary emails. Sendgrid Rails documentation can be found
[here.](https://sendgrid.com/docs/Integrate/Frameworks/rubyonrails.html)

# Wordpress
Whiteboard uses Wordpress integration to post standup summaries to the Pivotal Labs blog. Information on setting up the
Wordpress environment variables can be found in the [readme](./README.md).

# Optional Logging
We use [Papertrail](http://papertrail.com) to save our logs. Documentation for setting Papertrail up is found 
[here.](http://docs.run.pivotal.io/devguide/services/log-management-thirdparty-svc.html#papertrail)
