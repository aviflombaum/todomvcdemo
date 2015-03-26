require 'rails_helper'

describe 'TODOMVC', :type => :feature, :js => true do
  let!(:bucket_list){List.create(:name => "Bucket List")}

  context '/' do
    it 'can create a new todo list' do
      visit root_path # GET /lists lists#index

      fill_in "new-todo", with: "Shopping List"
      
      # Think about why we're using JS to submit the form.
      page.execute_script("$('form#new_list').submit()")
      # POST /lists lists#create

      expect(page).to have_content("Shopping List")
    end

    it 'deletes a list from the list index page' do
      visit root_path

      # I need to trigger clicking on that button
      # then my expectation is that the list is gone
      click_button "Destroy"
    end

    it 'lists existing todo lists with links to the list show page' do
      bucket_list

      # Tests that the index has the list.
      visit root_path
      expect(page).to have_content(bucket_list.name)

      # Tests that the index has a link to the list.
      click_link bucket_list.name

      # And that it ends up on a show page.
      # Could you think of a better way to test that you end up on the show page?
      expect(page).to have_content(bucket_list.name)
    end
  end

  context '/lists/:id' do
    before do
      @shopping_list = List.create(:name => "Shopping List")

      @shopping_list.items.create(:description => "Milk")
      @shopping_list.items.create(:description => "Eggs")
      @shopping_list.items.create(:description => "Butter")
      visit list_path(@shopping_list)
    end

    it 'displays items in a todo list' do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
      expect(page).to have_content("Butter")
    end

    it 'allows you to add an item to a list' do
      fill_in "new-todo", with: "Flour"
      page.execute_script("$('form').submit()")

      expect(page).to have_content("Flour")
    end
  end
end