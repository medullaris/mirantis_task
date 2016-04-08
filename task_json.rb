require 'json'
require 'test/unit'
require 'rspec/mocks'
module User
  JSON_FILE = 'user.json'
  def self.exists(users, login)
    return users.has_key?(login)
  end
  def self.verify(users, login, old_pass)
    return users[login] == old_pass

  end
  def self.change_pass(users, login, pass)
    users[login] = pass
  end
  def self.read(file)
     begin
      json = File.read(file)

    rescue Errno::ENOENT
      puts $!
      exit 0
    end
  end
  def self.write(file, users)
    begin
      File.open(file,'w') {|file| file.write(users.to_json)}
    rescue IOError
      puts $!
      exit 0
    end
  end
  def self.main(login, old_pass, new_pass, file)
    json = read(file)
    users = JSON.parse(json)

    #begin 
    #  users = JSON.parse(json)
    #rescue JSON::ParserError
    #  puts $!
    #  exit 0
    #end
    puts "Enter login:"
    #login = gets
    login = login.chomp

    if exists(users, login)
      puts "Enter old pass for " + login
      #old_pass = gets
      if verify(users, login, old_pass.chomp)
        puts " Enter new pass"
        #new_pass = gets
        change_pass(users, login, new_pass.chomp)
      else puts "Pass does not match"
      end
    else puts "No such user"
    end
    write(file, users)
  end
end

#class TestUser < Test::Unit::TestCase
#  USERS = JSON.parse(File.read('user.json'))
#  def test_exists
#    assert_equal(true,User.exists(USERS, "user1"))
#    assert_equal(false, User.exists(USERS, "user4"))
#  end
#  def test_verify
#    assert_equal(true, User.verify(USERS, "user1", "123"))
#    assert_equal(false, User.verify(USERS, "user1", "1234"))
#  end
#  def test_change_pass
#    assert_equal("123",User.change_pass(USERS,"user1","123"))
#  end
#  def test_main
#    file = 'user.json'
#    expected_hash = {"user1" => "123456","user2" => "12345"}
#    expect(User).to receive(:read).with(file).and_return({"user1" => "123","user2" => "12345"})
#    expect(User).to receive(:write).with(file, expected_hash)
#    User.main("user1","123", "123456", file)
#  end
#end
