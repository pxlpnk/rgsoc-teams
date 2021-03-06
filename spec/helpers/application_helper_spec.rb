require 'spec_helper'

describe ApplicationHelper do
  describe '.link_to_team_members' do
    before do
      @team  = create(:team)
      @user1 = create(:user, name: 'Trung Le')
      @user2 = create(:user, name: 'Hieu Le')
      @user3 = create(:user, name: 'Trang Le')
      @role1 = create(:student_role, user: @user1, team: @team)
      @role2 = create(:coach_role,   user: @user2, team: @team)
      @role3 = create(:mentor_role,  user: @user3, team: @team)
    end

    it 'should return link_to student based on role type' do
      link_to_team_members(@team).should           == link_to_team_member(@user2) + link_to_team_member(@user3) + link_to_team_member(@user1)
      link_to_team_members(@team, :student).should == link_to_team_member(@user1)
      link_to_team_members(@team, :coach).should   == link_to_team_member(@user2)
      link_to_team_members(@team, :mentor).should  == link_to_team_member(@user3)
    end
  end

  describe '.link_to_team_member' do
    let(:user) { create(:user, name: 'Trung Le', avatar_url: 'http://example.com/avatar.png') }

    it 'should include a link to the member' do
      link_to_team_member(user).should include("<a href=\"/users/#{user.id}\">Trung Le</a>")
    end

    it 'should include the avatar image' do
      link_to_team_member(user).should include("<img alt=\"Trung Le\" src=\"#{user.avatar_url}\" />")
    end
  end

  describe '.link_to_user_roles' do
    before do
      @team  = create(:team, name: '29-enim')
      @user1 = create(:user, name: 'Trung Le')
      @role2 = create(:coach_role,  user: @user1, team: @team)
      @role3 = create(:mentor_role, user: @user1, team: @team)
    end

    it 'should return link_to role based on student' do
      link_to_user_roles(@user1).should ==
        "<a href=\"/users?role=coach\">Coach</a> at <a href=\"/teams/#{@team.id}\">Team 29-enim (Sinatra)</a>, " +
        "<a href=\"/users?role=mentor\">Mentor</a> at <a href=\"/teams/#{@team.id}\">Team 29-enim (Sinatra)</a>"
    end
  end

  describe '.icon' do
    it 'should generate empty icons' do
      icon('edit').should == '<i class="icon-edit"></i>'
    end

    it 'should generate icons with text' do
      icon('edit', 'Edit').should == '<i class="icon-edit"></i> Edit'
    end
  end

  describe '#role_names' do
    before do
      @team  = create(:team)
      @user  = create(:user, name: 'Trung Le')
      @role1 = create(:coach_role,   user: @user, team: @team)
      @role2 = create(:mentor_role,  user: @user, team: @team)
    end

    it 'returns coach and mentor' do
      expect(role_names(@team, @user)).to eql 'Coach, Mentor'
    end
  end
end
