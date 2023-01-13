require "spec_helper"
require "normalizer.rb"

RSpec.describe "Normalizer" do
  let(:original_path) { File.join(File.dirname(__FILE__), "./fixtures/posts/2018-state-of-code-review-study/index.md") }
  let(:new_path) { File.join(File.dirname(__FILE__), "./fixtures/posts/2018-state-of-code-review-study.md") }

  it "adds the path to the metadata from the pathname" do
    Normalizer.new(path: original_path).call

    file = File.open(new_path)
    expect(file.readlines).to include(/permalink: "\/2018-state-of-code-review-study"/)
    File.delete(file)
  end

  it "iterates through an list of paths" do
    path = File.join(File.dirname(__FILE__), "./fixtures/posts")
    Normalizer.for_path(path)

    post1 = File.open(File.join(File.dirname(__FILE__), "./fixtures/posts/2018-state-of-code-review-study.md"))
    post2 = File.open(File.join(File.dirname(__FILE__), "./fixtures/posts/art.md"))

    expect(post1.readlines).to include(/permalink: "\/2018-state-of-code-review-study"/)
    expect(post2.readlines).to include(/permalink: "\/art"/)
    File.delete(post1)
    File.delete(post2)
  end
end
