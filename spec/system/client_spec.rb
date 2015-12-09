require_relative "spec_helper"

include GivenFilesystemSpecHelpers

describe "client" do
  use_given_filesystem(keep_files: true)

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

  it "installs gem from spec" do
    out = double
    allow(out).to receive(:puts)

    test = Httpotemkin::Test.new(out: out)

    test.run do |client|
      gem_tarball = File.expand_path("../data/red_herring-000.tar.gz", __FILE__)

      gem_dir = given_directory
      Dir.chdir(gem_dir) do
        Cheetah.run(["tar", "xzf", gem_tarball])
      end

      client.install_gem_from_spec(File.join(gem_dir, "red_herring",
        "red_herring.gemspec"))

      client.execute(["gem", "list", "red_herring"])

      expect(client.exit_code).to eq(0)
      expect(client.out).to match("red_herring (0.0.1)\n")
      expect(client.err.empty?).to be(true)
    end
  end

  it "executes command in custom working directory" do
    out = double
    allow(out).to receive(:puts)

    test = Httpotemkin::Test.new(out: out)

    test.run do |client|
      client.execute(["ls"], working_directory: "/srv")

      expect(client.exit_code).to eq(0)
      expect(client.out).to eq("ftp\nwww\n")
      expect(client.err.empty?).to be(true)
    end
  end

  it "captures stderr" do
    out = double
    allow(out).to receive(:puts)

    test = Httpotemkin::Test.new(out: out)

    test.run do |client|
      client.execute(["ls", "iamnothere"])

      expect(client.exit_code).to eq(2)
      expect(client.out).to eq("")
      expect(client.err).to eq("ls: cannot access iamnothere: No such file or directory\n")
    end
  end
end
