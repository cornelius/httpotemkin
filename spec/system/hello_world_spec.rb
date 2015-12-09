require_relative "spec_helper"

describe "hello world" do
  context "server started in test" do
    it "answers" do
      out = double
      allow(out).to receive(:puts)

      test = Httpotemkin::Test.new(out: out)
      test.add_server("server")

      test.run do |client|
        sleep 2
        client.execute(["curl", "-s", "server/hello"])

        expect(client.exit_code).to eq(0)
        expect(client.out).to eq("world\n")
        expect(client.err).to eq("")
      end
    end
  end

  context "server started before test" do
    before(:all) do
      out = StringIO.new
      @test = Httpotemkin::Test.new(out: out)
      @test.add_server("server")
      @test.up
      @client = @test.start_client
      sleep 2
    end

    it "answers once" do
      @client.execute(["curl", "-s", "server/hello"])

      expect(@client.exit_code).to eq(0)
      expect(@client.out).to eq("world\n")
      expect(@client.err).to eq("")
    end

    it "answers twice" do
      @client.execute(["curl", "-s", "server/hello"])

      expect(@client.exit_code).to eq(0)
      expect(@client.out).to eq("world\n")
      expect(@client.err).to eq("")
    end

    after(:all) do
      @test.down
    end
  end
end
