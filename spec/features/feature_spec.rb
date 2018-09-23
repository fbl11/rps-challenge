require './app/rps_app'

describe 'Features' do

  feature 'Welcoming player to page' do
    scenario 'Can run app and check page content' do
      visit('/')
      expect(page.status_code).to eq(200)
      expect(page).to have_content 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
    end
  end

# As a marketeer
# So that I can see my name in lights
# I would like to register my name before playing an online game
# the marketeer should be able to enter their name before the game

  feature 'Enter name' do
    scenario 'Player submits their name' do
      sign_in
      expect(page.status_code).to eq(200)
      expect(page).to have_content 'Choose your weapon, Freya!'
    end
  end

# As a marketeer
# So that I can enjoy myself away from the daily grind
# I would like to be able to play rock/paper/scissors
# the marketeer will be presented the choices (rock, paper and scissors)

  feature 'Get a choice of attacks' do
    scenario 'Player can chose between rock, paper or scissors' do
      sign_in
      expect(page.status_code).to eq(200)
      ['Rock', 'Paper', 'Scissors'].each do |weapon|
        expect(page).to have_selector("input[type=submit][value='#{weapon}']")
      end
      # expect(page).to have_selector("input[type=submit][value='Rock']")
      # expect(page).to have_selector("input[type=submit][value='Paper']")
      # expect(page).to have_selector("input[type=submit][value='Scissors']")
    end
  end

# the marketeer can choose one option
# the game will choose a random option

  feature 'Choose an attack' do
    scenario "Player selects 'Rock'" do
      sign_in
      click_button('Rock')
      expect(page.status_code).to eq(200)
      expect(page).to have_content("Freya has chosen 'Rock'")
    end
  end

  # test for specific content? regex?
  feature 'Computer chooses an attack' do
    scenario 'Computer selects Scissors' do
      sign_in
      click_button('Rock')
      expect(page.status_code).to eq(200)
      expect(page).to have_content("Computer - Hal has chosen")
    end
  end

  feature 'A winner will be declared' do
    scenario "When I submit 'Rock' I am told if I have won" do
      allow_any_instance_of(Weapons).to receive(:random_select).and_return(:scissors)
      sign_in
      click_button 'Rock'
      # Save page HTML to file
      # file = File.new('page.html', 'w')
      # file.write page.body + "\n"
      # file.close
      expect(page.status_code).to eq(200)
      expect(page).to have_content "Freya is the winner"
    end
  end

end
