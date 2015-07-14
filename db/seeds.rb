# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

List.delete_all
Item.delete_all

first_list = List.create(title: 'Explore Basecamp! — Some quick things to explore in Basecamp',
  description: 'A nice way to get acclimated.'
)

second_list = List.create(title: 'Explore Basecamp! — To-do list basics ')

#...

Item.create(text: %{ Click the "Invite more people" link at the top right corner
  to invite other people to this project.},
            list_id: first_list.id, position: 1)

Item.create(text: %{Upload a file to this project by just dragging a file
  (a picture, a Word doc, a PDF, whatever)
  right into your web browser and dropping it anywhere into this project.},
            list_id: first_list.id, position: 2)

Item.create(text: %{Explore Basecamp's totally unique page stacking interface. Click me to see how it works.},
            list_id: first_list.id, position: 3)

Item.create(text: %{Click the name of the project ("Explore Basecamp") in the top left corner
  to rename the project or change the description. Then click it again and change it to something else.},
            list_id: first_list.id, position: 4)


Item.create(text: %{This to-do has a due date.},
            list_id: second_list.id, position: 1)

Item.create(text: %{Click me > here < to see a discussion on a to-do.}, list_id: second_list.id, position: 2)

Item.create(text: %{< Click the box to my left to check me off as done.}, list_id: second_list.id, position: 3)

Item.create(text: %{Click and hold me anywhere on this line and drag me up to reorder.}, list_id: second_list.id, position: 4)

Item.create(text: %{Hover over me and click the button to my right to assign a due date >}, list_id: second_list.id, position: 5)

Item.create(text: %{Click the name of this to-do list to focus just on this list.}, list_id: second_list.id, position: 6)

Item.create(text: %{Click the "Add a to-do" link right below me to add your own to-do.}, list_id: second_list.id, position: 7)
