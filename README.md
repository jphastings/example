# Spiderman

Post a message to a public slack channel when someone deploys a github repo outside of standard support hours.

## Notes

This is a _very_ basic implementation of what this app could be. Things I'd like to include:

* Looking up slack usernames from github ones somehow
* Dealing with timezones (can we find out what timezone the deployer is in from the commits?)
* Optionally making a lead of a team responsible (rather than the individual)
* Posting an on-call override to PagerDuty when this happens
