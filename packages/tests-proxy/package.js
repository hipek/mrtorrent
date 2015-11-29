Package.describe({
	name: "velocity:test-proxy",
	summary: "Dynamically created package to expose test files to mirrors",
	version: "0.0.4",
	debugOnly: true
});

Package.onUse(function (api) {
	api.use("coffeescript", ["client", "server"]);
	api.add_files("tests/mocha/helpers/fixture.coffee",["server","client"]);
	api.add_files("tests/mocha/server/rtorrent/item_test.coffee",["server"]);
	api.add_files("tests/mocha/server/rtorrent/service/deserializer_test.coffee",["server"]);
	api.add_files("tests/mocha/server/rtorrent/service/scgi_request_test.coffee",["server"]);
});