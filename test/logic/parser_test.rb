require 'test_helper'

class ParserTest < ActionMailer::TestCase

  test "should return options" do
    parser = Parser.new 'is:todo author:vasyll@interlink-ua.com Click'
    assert_equal ({status: false, author: 'vasyll@interlink-ua.com', phrase: 'Click'}), parser.perform
  end

  test "should return options if params not ordered" do
    parser = Parser.new 'Click author:vasyll@interlink-ua.com is:done'
    assert_equal ({status: true, author: 'vasyll@interlink-ua.com', phrase: 'Click'}), parser.perform
  end

  test "should return options if many spaces present" do
    parser = Parser.new '  author  :   vasyll@interlink-ua.com      is  :   done     Click   '
    assert_equal ({status: true, author: 'vasyll@interlink-ua.com', phrase: 'Click'}), parser.perform
  end

end
