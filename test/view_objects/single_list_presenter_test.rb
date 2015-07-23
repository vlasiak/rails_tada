require 'test_helper'

class SingleListPresenterTest < ActiveSupport::TestCase
  fixtures :items

  def setup
    @list_with_items = FactoryGirl.build(:with_items)
    @list = SingleListPresenter.new @list_with_items
  end

  test "list id presence" do
    assert_equal list_with_items.id, list.id
  end

  test "list title presence" do
    assert_equal list_with_items.title, list.title
  end

  test "list description presence" do
    assert_equal list_with_items.description, list.description
  end

  test "list date creation presence" do
    assert_equal list_with_items.created_at, list.created_at
  end

  test "list creator presence" do
    assert_equal list_with_items.user.email, list.created_by
  end

  test "list has items" do
    assert list.has_items?
  end

  test "list's incompleted items are sorted by position column" do
    assert_equal [items(:fourth), items(:first)],
      list.incompleted_items
  end

  test "list's completed items are sorted by updated_at column" do
    assert_equal [items(:third), items(:second)],
      list.completed_items
  end

  private

  attr_reader :list, :list_with_items
end
