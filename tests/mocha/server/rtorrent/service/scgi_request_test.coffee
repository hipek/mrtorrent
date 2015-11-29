MochaWeb?.testOnly ->
  if Meteor.isServer
    describe "RTorrent.Service.SCGIRequest", ->
      subject = ->
        new RTorrent.Service.SCGIRequest 'system.method', 'main'

      describe "consts", ->
        it "has METHOD with POST", ->
          expect(RTorrent.Service.METHOD).to.eql 'POST'

        it "has URI with RPC2", ->
          expect(RTorrent.Service.URI).to.eql 'RPC2'

      it "has xmlrpc module", ->
        expect(subject().xmlrpc).to.be.defined

      describe "header", ->
        before ->
          @header = subject().header 'ab'

        it "has CONTENT_LENGTH", ->
          expect(@header).to.match ///CONTENT_LENGTH#{"\0"}2///

        it "has SCGI", ->
          expect(@header).to.match ///SCGI#{"\0"}1///

        it "has REQUEST_METHOD", ->
          expect(@header).to.match ///REQUEST_METHOD#{"\0"}POST///

        it "has REQUEST_URI", ->
          expect(@header).to.match ///REQUEST_URI#{"\0"}RPC2#{"\0"}///

      describe "toString", ->
        before ->
          @xml = subject().toString()

        it "returns xml request", ->
          expect(@xml).to.match /<methodName>system.method<\/methodName>/
          expect(@xml).to.match(
            /<params><param><value><string>main<\/string><\/value><\/param><\/params>/
          )
