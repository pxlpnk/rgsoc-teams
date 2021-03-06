class CommentMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: ENV['EMAIL_FROM']

  attr_reader :team, :comment
  helper_method :team, :comment

  def email(comment)
    set comment
    mail subject: subject, to: supervisors.map(&:email).compact.join(',')
  end

  private

    def supervisors
      Team.where(name: 'Supervisors').first.members
    end

    def subject
      "[rgsoc-teams] New comment: #{team.name} - #{truncate(comment.text)}"
    end

    def set(comment)
      @team = comment.team
      @comment = comment
    end
end


