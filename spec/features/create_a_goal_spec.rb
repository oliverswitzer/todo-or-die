require 'rails_helper'
require 'helpers/authentication_helper'

describe 'visiting the homepage', type: :feature do
  include AuthenticationHelper

  before do
    mock_omniauth_for_facebook
  end

  it 'user can create a goal' do
    givenIAmOnTheHomepage
    whenIClickCreateGoalCallToAction
    thenIAmLoggedIn
    thenIAmOnTheGoalCreationPage
    whenIFillOutTheForm
    thenIAmOnTheChooseAFriendPage
  end

  def thenIAmOnTheChooseAFriendPage
    expect(page).to have_content('Choose a Friend')
  end

  def whenIFillOutTheForm
    fill_in 'Goal name, e.g. "Finishing that damn Novel', with: 'My Goal'
    select 'Novel', from: 'What type of project are you working on?'
    fill_in 'How many words do you want to write?', with: '100'
    fill_in 'When I want to be done', with: '1 June, 2016'

    click_on 'Do It'
  end

  def thenIAmOnTheGoalCreationPage
    expect(page).to have_content('Set a goal for yourself')
  end

  def thenIAmLoggedIn
    expect(page).to have_content('Joe Bloggs')
  end

  def whenIClickCreateGoalCallToAction
    click_link_or_button 'Create Your Goal'
  end

  def givenIAmOnTheHomepage
    visit '/'
  end
end
