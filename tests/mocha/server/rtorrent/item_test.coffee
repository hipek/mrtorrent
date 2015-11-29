MochaWeb?.testOnly ->
  if Meteor.isServer
    describe "RTorrent.Item", ->
      it "has methods mapping", ->
        expect(typeof RTorrent.Item::methods).to.eql 'object'

      it "has get methods", ->
        expect(RTorrent.Item.getMethods()[0]).to.eql 'd.get_creation_date='
