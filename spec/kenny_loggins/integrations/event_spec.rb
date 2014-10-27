require 'spec_helper'

describe KennyLoggins::Event do
  describe ".create" do
    it "creates an event record" do
      application = KennyLoggins::Application.create(name: "cool app")

      KennyLoggins::Event.create(application: application, data: {foo: 'bar', stuff: { things: "and stuff" } })
      expect(KennyLoggins::Event.first.data).to eq({'foo' => 'bar'})
    end
  end
end
