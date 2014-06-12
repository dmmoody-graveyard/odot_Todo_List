require 'spec_helper'

describe "Editing our todo list" do
	let!(:todo_list) {todo_list = TodoList.create(title: "Groceries", description: "Grocery List.")}

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:desciption] ||= "This is what I'm doing today."
		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct information" do
		update_todo_list todo_list: todo_list, 
						 title: "New title", 
						 description: "New description"

		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq ("New description")
	end

	it "displays an error with no title" do
		update_todo_list todo_list: todo_list, title: ""
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content("error")
	end

	it "displays an error with too short a title" do
		update_todo_list todo_list: todo_list, title: "Hi"
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content('error')
	end

	it "displays an error with no description" do
		update_todo_list todo_list: todo_list, desciption: ""
		description = todo_list.description
		todo_list.reload
		expect(todo_list.description).to eq(description)
		expect(page).to have_content('error')
	end

	it "display an error with too short a desciption" do
		update_todo_list todo_list: todo_list, desciption: "hi"
		description = todo_list.description
		todo_list.reload
		expect(todo_list.description).to eq(description)
		expect(page).to have_content('error')
	end

end