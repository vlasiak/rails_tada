# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

List.delete_all
Item.delete_all

first_list = List.create(title: 'My first list',
  description: %{this is the test list}
)

second_list = List.create(title: 'Some other list',
  description: %{this is the second test list}
)

#...

Item.create(text: 'First item list 1', list_id: first_list.id)

Item.create(text: 'First item list 2', list_id: second_list.id)

Item.create(text: 'Second item list 1', list_id: first_list.id)

Item.create(text: 'Third item list 1', list_id: first_list.id)
