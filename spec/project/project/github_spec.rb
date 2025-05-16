require "spec_helper"

# rubocop:disable RSpec/DescribeClass
RSpec.describe "github" do
  describe "workflows" do
    it "always uses SHA locked workflows" do
      files = Dir[".github/**/*"]
      expect(files).not_to be_empty, "No files found in .github directory"

      files.each do |file|
        next unless File.file?(file)

        content = File.read(file)
        expect(content).not_to include("@v"), "File #{file} contains '@v'"
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass
