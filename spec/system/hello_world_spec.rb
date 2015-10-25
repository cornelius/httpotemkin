require_relative "spec_helper"

describe "hello world" do
  it "answers" do
    out = double
    allow(out).to receive(:puts)

    test = Httpotemkin::Test.new(out: out)
    test.add_server("server")

    test.run do |client|
      sleep 2
      client.execute(["curl", "server/hello"])

      expect(client.exit_code).to eq(0)
      expect(client.out).to eq("world\n")
      expect(client.err.empty?).to be(true)
    end
  end
end
