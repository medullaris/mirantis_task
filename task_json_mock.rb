require './task_json.rb'
describe "test_main" do
  it "some" do
    file = 'user.json'
    expected_hash = {"user1" => "123456","user2" => "12345"}
    expect(User).to receive(:read).with(file).and_return('{"user1": "123","user2": "12345"}')
    expect(User).to receive(:write).with(file, expected_hash)
    User.main("user1","123", "123456", file)
  end
  it "error hash" do
    file = 'user.json'
    expected_hash = {"user1" => "1234567","user2" => "12345"}
    expect(User).to receive(:read).with(file).and_return('{"user1":- "123","user2": "12345"}')
    #expect(User).to receive(:write).with(file, expected_hash)
    #expect(JSON.parse('{"user1": "123","user2": "12345"}')).to raise_error(JSON::ParserError)
    expect { User.main("user1","123", "123456", file) }.to raise_error(JSON::ParserError)
  end
end
