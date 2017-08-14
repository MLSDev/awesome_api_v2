defmodule AwesomeApiV2.MessageControllerTest do
  use ESpec, focus: true

  require Logger

  before do: {:shared, a: 1}

  let! :a, do: shared.a
  let :b, do: shared.a + 1

  it do: expect a() |> to(eq 1)
  it do: expect b() |> to(eq 2)

  example_group do
    context "Some context" do
      it do: expect "abc" |> to(match ~r/b/)
    end

    describe "Some another context with opts", focus: true do
      it do: 5 |> should(be_between 4, 6)
    end
  end

  context "context with tag", context_tag: :some_tag do
    it do: "some example"
    it "example with tag", example_tag: true do
     "another example"
    end
  end

  # xit "skip", do: "skipped"
  focus "Focused", do: "Focused example"

  # it "pending example"
  # pending "it is also pending example"

  context "Context" do
    before do: {:shared, %{b: shared[:a] + 1}}
    finally do: "#{shared[:b]} == 2"

    it do: shared.a |> should(eq 1)
    it do: shared.b |> should(eq 2)

    finally do: "This finally will not be run. Define 'finally' before the example"
  end

  example_group do
    subject(24)

    Enum.map 2..4, fn(n) ->
      it "is divisible by #{n}" do
        expect(rem(subject(), unquote(n))).to be(0)
      end
    end
  end

  it "tests capture_log" do
    message = capture_log(fn -> Logger.error "log msg" end)
    expect message |> to(match "log msg")
  end

  context "just some tests" do
    subject do: 1+1

    it do: should eq 2
  end

  context "#show.json" do

  end
end
