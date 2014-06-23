require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_lists) { TodoList.create(title: "Grocery List", description: "Groceries") }
	it "displays no items when a todo list is empty" do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "List items"
		end
		expect(page).to have_content("TodoItems#index")
	end
end