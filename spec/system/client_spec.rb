require_relative "spec_helper"

describe "client" do
  it "injects tarballs" do
    out = double
    allow(out).to receive(:puts)

    test = Httpotemkin::Test.new(out: out)

    test.run do |client|
      client.inject_tarball("spec/system/data/test.tar.gz")

      client.execute(["ls", "test"])

      expect(client.exit_code).to eq(0)
      expect(client.out).to eq("mydir\nmyfile\n")
      expect(client.err.empty?).to be(true)

      client.execute(["ls", "test/mydir"])

      expect(client.exit_code).to eq(0)
      expect(client.out).to eq("myotherfile1\nmyotherfile2\n")
      expect(client.err.empty?).to be(true)
    end
  end
end
