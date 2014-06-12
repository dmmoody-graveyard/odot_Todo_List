require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:desciption] ||= "This is what I'm doing today."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:desciption]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has no desciption" do
		expect(TodoList.count).to eq(0)

		create_todo_list desciption: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has a desciption less than 5 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list desciption: "Food"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

end