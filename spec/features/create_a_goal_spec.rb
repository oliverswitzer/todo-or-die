require 'rails_helper'
require 'bundler/settings'
require 'helpers/authentication_helper'

describe 'visiting the homepage', type: :feature do
  it 'user can create a goal' do
    givenIAmOnTheHomepage
    whenIClickCreateGoalCallToAction
    whenIAuthorizeWithFacebook
    thenIAmLoggedIn
    thenIAmOnTheGoalCreationPage
    whenIFillOutTheForm
    thenIAmOnTheChooseAFriendPage
    thenISeeMyFriends
    whenIClickOnOneOfMyFriends
    thenISeeACountdownToMyGoalCompletion
  end

  private

  def thenISeeACountdownToMyGoalCompletion
    expect(page).to have_content('Complete your goal before the timer below runs out!')
  end

  def whenIClickOnOneOfMyFriends
    click_on 'Oliver Switzer'
  end

  def whenIAuthorizeWithFacebook
    fill_in(id: 'email', with: ENV['TEST_USER_EMAIL'])
    fill_in(id:  'pass', with: ENV['TEST_USER_PASSWORD'])
    click_on 'Log In'

    click_button 'Continue as Oliver' if page.text.include? 'Continue as Oliver'
    click_button 'OK' if page.text.include? 'OK'
  end

  def thenISeeMyFriends
    # need to add more users to my friends list on my test account,
    # for now I'm its only friend :(
    expect(page).to have_content('Oliver Switzer')
  end

  def thenIAmOnTheChooseAFriendPage
    expect(page).to have_content('Choose a Friend')
  end

  def whenIFillOutTheForm
    fill_in 'Goal name, e.g. "Finishing that damn Novel', with: 'My Goal'

    # TODO: Figure out how to select from goal_type dropdown
    # select 'Novel', from: '#goal_goal_type'

    fill_in 'How many words do you want to write?', with: '100'
    fill_in 'When I want to be done', with: '1 June, 2016'

    click_on 'Do It'
  end

  def thenIAmOnTheGoalCreationPage
    expect(page).to have_content('Set a goal for yourself')
  end

  def thenIAmLoggedIn
    within_window ->{ sleep 1; page.title == 'TodoOrDie' } do
      expect(page).to have_content('Oli Switz')
    end
  end

  def whenIClickCreateGoalCallToAction
    click_link_or_button 'Create Your Goal'
  end

  def givenIAmOnTheHomepage
    visit '/'
  end
end
