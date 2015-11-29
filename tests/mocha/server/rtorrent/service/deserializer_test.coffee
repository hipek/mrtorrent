MochaWeb?.testOnly ->
  if Meteor.isServer
    describe "RTorrent.Service.Deserializer", ->
      describe "string and array", ->
        before ->
          @xml = Fixture.load 'all_methods.xml'
          @deserializer = new RTorrent.Service.Deserializer(@xml)

        it "returns arary of objects", ->
          @deserializer.parse (err, result) ->
            expect(result.length).to.eql 962
            expect(result[0]).to.eql 'system.listMethods'
            expect(result[961]).to.eql 'xmlrpc_size_limit'

      describe "nested array and i8", ->
        before ->
          @xml = Fixture.load 'multi_response.xml'
          @deserializer = new RTorrent.Service.Deserializer(@xml)

        it "returns arary of objects", ->
          @deserializer.parse (err, result) ->
            expect(result.length).to.eql 2
            expect(result[0][0]).to
              .eql 'Desktop iCalendar'
            expect(result[0][1]).to
              .eql 3173195
            expect(result[0][2]).to
              .eql 1
            expect(result[1][1]).to
              .eql 375206748
