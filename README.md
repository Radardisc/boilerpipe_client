### Boilerpipe Client

This is a small Erlang OTP application which connects to the boilerpipe_node

### License
All code in this library comes under the P2P Production License 
http://p2pfoundation.net/Peer_Production_License

Essentially, you can use it for fun or to learn, or as part of an open source library / system for free, 
but a commerical enterprise should request the ability to use, change or update the code for their commercial purpose. 
This may incur a fee. Please contact us through github to discuss your requirements

### Rationale

We have the node made (see https://github.com/Radardisc/boilerpipe_node )
Now we want to connect to it from our erlang nodes

### Build

You need to get rebar

rebar compile

### Integrate

However you decide to use this, you will need to configure the boilerpipe_node and server name in order to use it

e.g.

`{ boilerpipe_client, remote_server, { ServerName, NodeName } }`

By default, this is

`{boilerpipe, boilerpipe@Localhost}`

where Localhost is your machine name

### Tests

There are some quick tests, however you need to work out how to set the `node name` for the eunit test suite, and the cookie to match the node

