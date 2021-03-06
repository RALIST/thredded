# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'User editing a private topic' do
  it 'can edit a topic they started' do
    user.log_in
    topic = private_topic
    topic.visit_topic_edit

    expect(topic).to be_editable
  end

  it 'updates topic title' do
    user.log_in
    topic = private_topic
    topic.visit_topic_edit
    topic.change_title_to('this is changed')
    topic.submit

    expect(topic).to have_content('this is changed')
  end

  def user
    @user ||= create(:user)
    PageObject::User.new(@user)
  end

  def private_topic
    topic = create(:private_topic, posts: FactoryBot.build_list(:private_post, 3), user: @user)
    PageObject::PrivateTopic.new(topic)
  end
end
